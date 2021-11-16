abstract class SocilaRegisterStates {}

class SocilaRegisterInitialStates extends SocilaRegisterStates {}

class ChangeRegisterPasswordVisibilityStates extends SocilaRegisterStates {}

class SocilaRegisterLoadingStates extends SocilaRegisterStates {

}

class SocilaRegisterSuccessStates extends SocilaRegisterStates {
  final String? uid;

  SocilaRegisterSuccessStates(this.uid);
}

class SocilaRegisterErrorStates extends SocilaRegisterStates {}

class SocilaUserSuccessStates extends SocilaRegisterStates {}

class SocilaUserErrorStates extends SocilaRegisterStates {
  final String error;

  SocilaUserErrorStates(this.error);
}
