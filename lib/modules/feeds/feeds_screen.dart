import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/create_post_model.dart';
import 'package:social/modules/add_post/add_post_screen.dart';
import 'package:social/modules/comment/comment_screen.dart';
import 'package:social/shared/componets/components.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.model != null ,
          builder: (context) => Column(
            children: [
              Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 7.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            '${cubit.model!.image}',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            navigatorTo(context, AddPostScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'What\'s on your mind',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildPostItem(context, cubit.postModelAdd[index],index),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8.0,
                ),
                itemCount: cubit.postModelAdd.length,
              ),
              const SizedBox(
                height: 15.0,
              )
            ],
          ),
          fallback: (context) =>
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 300.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        );
      },
    );
  }

  Widget buildPostItem(context, CreatePostModel model,index) {

    return
    Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 5.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
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
                              '${model.name}',
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
                            const Icon(
                              Icons.check_circle,
                              size: 16.0,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        Text(
                          '${model.dataTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      height: 1.5,
                      fontSize: 15.0,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: SizedBox(
                          height: 20.0,
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Text(
                              '#software',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            minWidth: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: const Text(
                              '#software',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            minWidth: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(model.postImage != null)
                Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: 400.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${model.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text('${SocialCubit.get(context).likes[index]}')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('${SocialCubit.get(context).comment[index]}')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18.0,
                              backgroundImage: NetworkImage(
                                '${model.image}',
                              ),
                            ),
                            const SizedBox(
                              width: 7.0,
                            ),
                            Text(
                              'Write a comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        navigatorTo(context, CommentScreen(uIdIndex: SocialCubit.get(context).postsId[index],));
                        // SocialCubit.get(context).popPage(context);
                      },
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      SocialCubit.get(context).getLikePost(postId: SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );}
}
