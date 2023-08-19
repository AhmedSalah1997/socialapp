abstract class SocialLoginStates {}

class SocialLoigninitalState extends SocialLoginStates {}

class SocialLoignLoadState extends SocialLoginStates {}

class SocialLoignSuccessState extends SocialLoginStates {
  final String uId;

  SocialLoignSuccessState(this.uId);
}

class SocialLoignErroeState extends SocialLoginStates {
  final String error;

  SocialLoignErroeState(this.error);
}
