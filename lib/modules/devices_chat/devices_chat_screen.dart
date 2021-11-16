
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/shared/styles/icon_broken.dart';

class DevicesChatScreen extends StatelessWidget {
  SocialUserModel socialUserModel;

  DevicesChatScreen({Key? key, required this.socialUserModel})
      : super(key: key);

  final _messageController = TextEditingController();

  DateFormat dateFormat = DateFormat("HH:mm:ss");


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: socialUserModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, states) {},
          builder: (context, states) {
            var cubitMessage = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage(
                          '${socialUserModel.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 5.0, start: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${socialUserModel.name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: const Icon(IconBroken.Arrow___Left_2),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              body: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubitMessage.messages.length > 0,
                      builder: (context) => Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message = cubitMessage.messages[index];
                                print(cubitMessage.messages[index].toMapMessage());
                                if(socialUserModel.uId == message.receiverId) {

                                  return builderMessageReceiver(message);
                                }
                                return builderMessageSend(message);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 5.0,
                              ),
                              itemCount: cubitMessage.messages.length,
                            ),
                          ),
                        ],
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: 'Type your message here',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: InkWell(
                          child: const Icon(Icons.camera_alt),
                          onTap: () {},
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubitMessage.sendMessage(
                              receiverId: socialUserModel.uId!,
                              text: _messageController.text,
                              dataTime: Timestamp.now().toString()
                            );
                            _messageController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black, height: 1),
                    ),
                  ),
                ],
              ),
            );
            // const Center(child: CircularProgressIndicator()),
          }
        );
      },
    );
  }

  Widget builderMessageSend(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            child: Text(
              model.text!,
              style: TextStyle(fontSize: 18.0),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          ),
        ),
      );

  Widget builderMessageReceiver(MessageModel model) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            child: Text(
              model.text!,
              style: TextStyle(fontSize: 18.0),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          ),
        ),
      );
}
