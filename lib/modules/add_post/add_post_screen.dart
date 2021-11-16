import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/componets/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class AddPostScreen extends StatelessWidget {
  var _textController = TextEditingController();

  AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        var now = DateTime.now();
        return Scaffold(
          appBar: defaultAppBar(leading:IconButton(
            icon: Icon(IconBroken.Arrow___Left_2),
            onPressed: () {
              Navigator.pop(context);
            },
          ),text: 'Add Post', context: context, actions: [
            textBottomItem(
              text: 'POST',
              onPressed: () {
                if (cubit.createNewPost == null) {
                  cubit.createPost(
                    dataTime: now.toString(),
                    text: _textController.text,
                  );
                } else {
                  cubit.uploadNewPostImage(
                    dataTime: now.toString(),
                    text: _textController.text,
                  );
                }
                _textController.clear();
              },
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(states is SocialCreateNewPostLoadingStates)
                  const Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 10.0),
                    child: LinearProgressIndicator(),
                  ),
                Row(
                  children: [
                     CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage('${cubit.model!.image}'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${cubit.model!.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 15.0,
                                      height: 1.0,
                                    ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                          Text(
                            'Public',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        hintStyle:
                            Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 25.0,
                                  color: Colors.grey,
                                ),
                        border: InputBorder.none),
                  ),
                ),
                if (cubit.createNewPost != null)
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 250.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    topRight: Radius.circular(7.0),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(cubit.createNewPost!),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            TextButton(
                              onPressed: () {
                                cubit.removeImagePost();
                              },
                              child: Icon(
                                Icons.close,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getImagePost();
                        },
                        child: Icon(IconBroken.Image),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '#Tags',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
