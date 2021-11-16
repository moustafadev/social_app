import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login_social/login_cubit/states_login.dart';

class SocialLoginCubit extends Cubit<SocilaLoginStates> {
  SocialLoginCubit() : super(SocilaLoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData? prefix = Icons.visibility_off;

  void changeLoginPasswordVisibility() {
    isPassword = !isPassword;
    prefix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangeLoginPasswordVisibilityStates());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocilaLoginLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);

      emit(SocilaLoginSuccessStates(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(SocilaLoginErrorStates(error.toString()));
    });
  }
}
