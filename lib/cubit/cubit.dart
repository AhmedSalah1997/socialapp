import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/commponent/constans/constans.dart';
import 'package:socialapp/cubit/stats.dart';
import 'package:socialapp/models/model_social_app.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/feeds/feeds_screen.dart';
import 'package:socialapp/modules/settinges/setting_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';

import '../models/create_comment.dart';
import '../models/message.dart';
import '../modules/new_post/new_post_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen = const [
    FeedsScreen(),
    ChatsScreen(),
    NewPoatScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> titles = [
    'Facebook',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    // if (index == 4) {
    //   getUserData();
    // }
    currentIndex = index;
    emit(SocialChandBottmNavScucessState());
  }

  XFile? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      emit(SocialImageProfileErorrState('erorr'));
      print('no image');
    } else {
      emit(SocialImageProfileScucessState());
      profileImage = pickedFile;
    }
  }

  XFile? coverImage;
  // var coverpicker = ImagePicker();

  Future<void> getCoverfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      emit(SocialCoverProfileErorrState('erorr'));
      print('no image');
    } else {
      emit(SocialCoverProfileScucessState());
      coverImage = pickedFile;
    }
  }

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      print(value.data());
      // getPosts();
      emit(SocialGetUserScucessState());
    }).catchError((e) {
      emit(SocialGetUserErorrState(e.toString()));
      print(e.toString());
    });
  }

  // String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usera/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(File(profileImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(UpoladProfileImageSuccessState());

        updateUserData(
          bio: bio,
          name: name,
          phone: phone,
          imageProfile: value,
        );
        profileImage = null;
      }).catchError((e) {
        emit(UpoladProfileImageErrorState());
        // print('this is waring hear ');
        // print(e.toString());
      });
    }).catchError((e) {
      emit(UpoladProfileImageErrorState());
      // print('error hear ');
    });
  }

  void cover({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('usera/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(File(coverImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(UpoladCovermageSuccessState());

        updateUserData(
          bio: bio,
          name: name,
          phone: phone,
          cover: value,
        );
        coverImage = null;
      }).catchError((e) {
        emit(UpoladCoverImageErrorState());
        // print('this is waring hear ');
        // print(e.toString());
      });
    }).catchError((e) {
      emit(UpoladCoverImageErrorState());
      // print('error hear ');
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUploadLoadingState());
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverfileImage != null) {
  //     uploadCoverFileImage();
  //   } else {
  //     updateUserData(bio: bio, name: name, phone: phone);
  //   }
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? imageProfile,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      imageCover: cover ?? userModel!.imageCover,
      image: imageProfile ?? userModel!.image,
      isEmailVerified: false,
      email: userModel!.email,
      uId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      getUserData();
      emit(SocialUserUpdateErrorState());
      print('error');
    });
  }

  XFile? postImage;
  // var coverpicker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      emit(SocialCreateImageErorrState('erorr'));
      print('no image');
    } else {
      emit(SocialCreateImageScucessState());
      postImage = pickedFile;
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemaoveCreateImageState());
  }

  void uploadePostImage({
    required String date,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(File(postImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          date: date,
          text: text,
          postImage: value,
        );
      }).catchError((e) {
        emit(UpoladCreatePostErrorState());
        // print('this is waring hear ');
        // print(e.toString());
      });
    }).catchError((e) {
      emit(UpoladCreatePostErrorState());
      // print('error hear ');
    });
  }

  String postUid = '';
  void createPost({
    required String date,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      date: date,
      postImage: postImage ?? '',
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      print(value.id);
      emit(SocialCreatePostSuccessState());
    }).catchError((e) {
      getUserData();
      emit(UpoladCreatePostErrorState());
      print('error');
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
      for (var element in value.docs) {
        posts = [];
        element.reference.collection('likes').snapshots().listen((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
        // .catchError(((onError) {}));
      }
      emit(SocialGetPostsScucessState());
    });
    // .catchError((error) {
    //   emit(SocialGetPostsrErorrState());
    // });

    // FirebaseFirestore.instance.collection('posts').snapshots().listen((value) {
    //   for (var element in value.docs) {
    //     element.reference.collection('comments').snapshots().listen((value) {
    //       commentIndex.add(value.docs.length);
    //       // postsId.add(element.id);
    //       // posts.add(PostModel.fromJson(element.data()));
    //     });
    //     // .catchError(((onError) {}));
    //   }
    //   // emit(SocialGetPostsScucessState());
    // });
    // // .catchError((error) {
    // //   emit(SocialGetPostsrErorrState());
    // // });
  }

  List<int> commentIndex = [];
  void getPostsComuntIndex() {
    emit(SocialGetComuntLoadingState());

    try {
      FirebaseFirestore.instance
          .collection('posts')
          .snapshots()
          .listen((value) {
        for (var element in value.docs) {
          element.reference.collection('comments').snapshots().listen((value) {
            commentIndex.add(value.docs.length);
            // postsId.add(element.id);
            // posts.add(PostModel.fromJson(element.data()));
          });
          // .catchError(((onError) {}));
        }
        emit(SocialGetComuntScucessState());
      });
    } on Exception catch (e) {
      emit(SocialGetComuntrErorrState());
    }
    // .catchError((error) {
    //   emit(SocialGetComuntrErorrState());
    // });
  }

  List<CraeteCommentModel> comments = [];

  void getComments({
    required String postId,
  }) {
    emit(SocialCommentePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        // .doc(userModel!.uId)
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        comments = [];
        comments.add(CraeteCommentModel.fromJson(element.data()));
      }
      emit(SocialCommentePostScucessState());
    });
    // FirebaseFirestore.instance.collection('posts').get().then((value) {
    //   for (var element in value.docs) {
    //     element.reference.collection('comments').get().then((value) {
    //       commentIndex.add(value.docs.length);

    //       comments.add(CraeteCommentModel.fromJson(element.data()));
    //       for (var el in value.docs) {
    //         comments.add(CraeteCommentModel.fromJson(element.data()));
    //         // postUid = el.id;
    //         print(el.toString());
    //       }

    //       postsId.add(element.id);
    //       comments.add(CraeteCommentModel.fromJson(element.data()));
    //     }).catchError(((onError) {}));
    //   }
    //   emit(SocialCommentePostScucessState());
    // }).catchError((error) {
    //   emit(SocialCommentPostErorrState());
    // });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLiskePostScucessState());
    }).catchError((e) {
      emit(SocialLiskePostErorrState());
    });
  }

  bool isShow = false;
  void commetSend(bool comment) {
    emit(SocialcommuntShowState());
    isShow = comment;
    // emit(SocialcommuntShowState());
    print(isShow.toString());
  }

  void commentPost(
      {required String comment,
      required String postId,
      required String date,
      required String image,
      required String name}) {
    CraeteCommentModel mode = CraeteCommentModel(
      name: name,
      image: image,
      date: date,
      comments: comment,
      uId: uId,
      postUid: postId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set(
          mode.toMap(),
        )
        .then((value) {
      emit(SocialCommentePostScucessState());
    }).catchError((e) {
      emit(SocialCommentPostErorrState());
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    emit(SocialAllUserLoadingState());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
        emit(SocialAllUserScucessState());
      }
    }).catchError((onError) {
      emit(SocialAllUserErorrState(onError.toString()));
    });
  }

  void sendMeaasge(
      {required String receierId,
      required String dateTime,
      required String text}) {
    MesseageModel model = MesseageModel(
      sendId: userModel!.uId,
      dateTime: dateTime,
      receierId: receierId,
      text: text,
    );

    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receierId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageScucessState());
    }).catchError((e) {
      emit(SocialSendMessageErorrState());
    });
// set other chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receierId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageScucessState());
    }).catchError((e) {
      emit(SocialSendMessageErorrState());
    });
  }

  List<MesseageModel> messgaes = [];

  void getMessage({
    required String receierId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receierId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messgaes = [];
      for (var element in event.docs) {
        messgaes.add(MesseageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageScucessState());
    });
  }

  List<SocialUserModel> searchModel = [];

  void searchUser({required String nameSerach}) {
    emit(SocialSerachUsersLoadingState());
    searchModel = [];
    FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: nameSerach.toLowerCase())
        .get()
        .then((event) {
      for (var element in event.docs) {
        searchModel = [];
        // emit(SocialSerachUsersLoadingState());
        // if (element.data()['uId'] == userModel!.uId) {
        searchModel.add(SocialUserModel.fromJson(element.data()));
        emit(SocialSerachUsersScucessState());

        // }
      }
    });
  }
}

  // void getUsers() {
  //   emit(SocialAllUserLoadingState());
  //   users = [];
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     for (var element in value.docs) {
  //       if (element.data()['uId'] != userModel!.uId) {
  //         users.add(SocialUserModel.fromJson(element.data()));
  //       }
  //       emit(SocialAllUserScucessState());
  //     }
  //   }).catchError((onError) {
  //     emit(SocialAllUserErorrState(onError.toString()));
  //   });
  // }