
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login_social/login_screen.dart';
import 'package:social/shared/componets/constants.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/network/remote/dio_helper.dart';
import 'package:social/shared/styles/blok_observe.dart';
import 'package:social/shared/styles/theme.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home_layout_screen.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  Widget startScreen;

  uId = CacheHelper.getData('uId');

  tokenFire = (await FirebaseMessaging.instance.getToken())!;
  print('<<<<<$tokenFire>>');




  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('event.data.toString()');
    print(event.data.toString());
  });

  if(uId != null)
    {
      startScreen = const HomeLayoutScreen();
    }else{
    startScreen = LoginSocialScreen();
  }





  runApp(MyApp(startScreen: startScreen,));
}

class MyApp extends StatelessWidget {


  final Widget startScreen;

  MyApp({required this.startScreen});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialCubit>(
        create: (BuildContext context) => SocialCubit()..getUserData()..getPost()..getComment()..getAllUsers(),
        child: BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, states) {},
            builder: (context, states) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeLite,
                darkTheme: themeDark,
                themeMode: ThemeMode.light,
                home: startScreen,
              );
            })
    );
  }
}
