abstract class SocilaLoginStates {}


class SocilaLoginInitialStates extends SocilaLoginStates {}

class ChangeLoginPasswordVisibilityStates extends SocilaLoginStates {}

class SocilaLoginLoadingStates extends SocilaLoginStates {}

class SocilaLoginSuccessStates extends SocilaLoginStates {
  final String uId;

  SocilaLoginSuccessStates(this.uId);
}

class SocilaLoginErrorStates extends SocilaLoginStates {
  final String error;

  SocilaLoginErrorStates(this.error);
}
