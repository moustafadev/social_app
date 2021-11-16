import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/devices_chat/devices_chat_screen.dart';
import 'package:social/shared/componets/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.allUsers!.length > 0 && cubit.allUsers != null,
          builder: (context) => ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  builderChatItem(cubit.allUsers![index], index, context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              itemCount: cubit.allUsers!.length),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderChatItem(SocialUserModel model, index, context) => InkWell(
    onTap: (){
      navigatorTo(context, DevicesChatScreen(socialUserModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 20.0),
      child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10.0,start: 5.0),
                      child: Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
    ),
  );
}
