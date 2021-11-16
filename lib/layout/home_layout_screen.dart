import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/modules/login_social/login_screen.dart';
import 'package:social/modules/notification/notification_screen.dart';
import 'package:social/shared/componets/components.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/styles/icon_broken.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            leading: null,
            context: context,
            text: cubit.label[cubit.currentIndex],
            actions: [
              IconButton(
                onPressed: () {
                  navigateAndFinish(context, LoginSocialScreen());
                },
                icon: const Icon(IconBroken.Logout),
              ),
              IconButton(
                onPressed: () {
                  navigatorTo(context, const NotificationScreen());
                },
                icon: const Icon(IconBroken.Notification),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: true,
                  builder: (context) {
                    return Column(children: [
                      if (FirebaseAuth.instance.currentUser!.emailVerified)
                        Container(
                          height: 50.0,
                          color: HexColor('ffc300').withOpacity(0.6),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                const Expanded(
                                  child: Text(
                                    'please verify your email',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                textBottomItem(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification()
                                        .then((value) {
                                      showToast(
                                          text: 'Check your email',
                                          color: HexColor('ffc300'));
                                    });
                                  },
                                  text: 'Send',
                                )
                              ],
                            ),
                          ),
                        )
                    ]);
                  },
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
                cubit.pagesScreen[cubit.currentIndex],
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: SocialCubit.get(context).currentIndex,
            onTap: (index) {
              SocialCubit.get(context).changeNavbarBottom(index: index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: cubit.label[0],
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: cubit.label[1]),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: cubit.label[2]),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Profile), label: cubit.label[3]),
            ],
          ),
        );
      },
    );
  }
}
