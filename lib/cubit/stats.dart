abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

// get users

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserScucessState extends SocialStates {}

class SocialGetUserErorrState extends SocialStates {
  final String erorr;

  SocialGetUserErorrState(this.erorr);
}

// bottom navi
class SocialChandBottmNavScucessState extends SocialStates {}

//
class SocialNewsPostState extends SocialStates {}

class SocialImageProfileScucessState extends SocialStates {}

class SocialImageProfileErorrState extends SocialStates {
  final String erorr;

  SocialImageProfileErorrState(this.erorr);
}

class SocialCoverProfileScucessState extends SocialStates {}

class SocialCoverProfileErorrState extends SocialStates {
  final String erorr;

  SocialCoverProfileErorrState(this.erorr);
}

// class UpoladProfileImageSuccessState extends SocialStates {}

class UpoladProfileImageLoadingState extends SocialStates {}

class UpoladProfileImageErrorState extends SocialStates {}

class UpoladCovermageSuccessState extends SocialStates {}

class UpoladCoverImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUploadLoadingState extends SocialStates {}

// crate Post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class UpoladCreatePostErrorState extends SocialStates {}

// postImage

class SocialCreateImageScucessState extends SocialStates {}

class SocialCreateImageErorrState extends SocialStates {
  final String erorr;

  SocialCreateImageErorrState(this.erorr);
}

// remaove post photo

class SocialRemaoveCreateImageState extends SocialStates {}

// get post

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsScucessState extends SocialStates {}

class SocialGetPostsrErorrState extends SocialStates {}

// get communt index

class SocialGetComuntLoadingState extends SocialStates {}

class SocialGetComuntScucessState extends SocialStates {}

class SocialGetComuntrErorrState extends SocialStates {}

// like post

class SocialLiskePostScucessState extends SocialStates {}

class SocialLiskePostErorrState extends SocialStates {}

// comment post

class SocialCommentePostLoadingState extends SocialStates {}

class SocialCommentePostScucessState extends SocialStates {}

class SocialCommentPostErorrState extends SocialStates {}

// commentshow

class SocialcommuntShowState extends SocialStates {}

// get all of users

class SocialAllUserLoadingState extends SocialStates {}

class SocialAllUserScucessState extends SocialStates {}

class SocialAllUserErorrState extends SocialStates {
  final String erorr;

  SocialAllUserErorrState(this.erorr);
}

// send message
class SocialSendMessageScucessState extends SocialStates {}

class SocialSendMessageErorrState extends SocialStates {}

// get message
class SocialGetMessageScucessState extends SocialStates {}

class SocialButtonSend extends SocialStates {}

//search users
class SocialSerachUsersLoadingState extends SocialStates {}

class SocialSerachUsersScucessState extends SocialStates {}
