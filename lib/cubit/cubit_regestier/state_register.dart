abstract class SociaRegisterStates {}

class SocialRegisterinitalState extends SociaRegisterStates {}

class SocialRegisterLoadState extends SociaRegisterStates {}

class SocialRegisterSuccessState extends SociaRegisterStates {}

class SocialRegisterErroeState extends SociaRegisterStates {
  final String error;

  SocialRegisterErroeState(this.error);
}

class SocialCreateUserSuccessState extends SociaRegisterStates {}

class SocialCreateUserErroeState extends SociaRegisterStates {
  final String error;

  SocialCreateUserErroeState(this.error);
}
