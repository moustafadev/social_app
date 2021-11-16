import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/register_social/register_cubit/states_register.dart';

class SocialRegisterCubit extends Cubit<SocilaRegisterStates> {
  SocialRegisterCubit() : super(SocilaRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData? prefix = Icons.visibility_off;

  void changeRegisterPasswordVisibility() {
    isPassword = !isPassword;
    prefix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangeRegisterPasswordVisibilityStates());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocilaRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.uid);
      userCreateData(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(SocilaRegisterSuccessStates(value.user!.uid));
    }).catchError(
      (error) {
        print(error.toString());
        emit(SocilaRegisterErrorStates());
      },
    );
  }

  void userCreateData({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      phone: phone,
      uId: uId,
      name: name,
      isEmailVerified: false,
      image:
          'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
      bio: 'Write Bio'
    );
    FirebaseFirestore.instance
        .collection(
          'users',
        )
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(SocilaUserSuccessStates());
    }).catchError((error) {
      emit(SocilaUserErrorStates(error));
    });
  }
}
