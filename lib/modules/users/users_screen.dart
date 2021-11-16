import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/user_friend/user_friend_screen.dart';
import 'package:social/shared/componets/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  builderRequestItem(context, cubit.allUsers![index], cubit),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
              itemCount: cubit.allUsers!.length),
        );
      },
    );
  }

  Widget builderRequestItem(
          context, SocialUserModel model, SocialCubit cubit) =>
      InkWell(
        onTap: () {
          navigatorTo(
              context,
              UserFriendsScreen(
                model: model,
              ));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20.0),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    MaterialButton(
                        height: 35,
                        color: cubit.pending
                            ? Colors.grey[500]
                            : Colors.blueAccent,
                        onPressed: () {
                          cubit.pendingFriend(
                              image: model.image!,
                              name: model.name!,
                              receiverId: model.uId!,
                              dataTime: Timestamp.now().toString());
                        },
                        child: cubit.pending
                            ? Text(
                                'Requested',
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                'Add Friend',
                                style: TextStyle(color: Colors.white),
                              )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    MaterialButton(
                      height: 35,
                      color: Colors.blueAccent,
                      onPressed: () {

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Remove',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
}
