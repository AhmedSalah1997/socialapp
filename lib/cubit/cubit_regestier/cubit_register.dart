import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit_regestier/state_register.dart';
import 'package:socialapp/models/model_social_app.dart';

class SociaRegisterCubit extends Cubit<SociaRegisterStates> {
  SociaRegisterCubit() : super(SocialRegisterinitalState());

  static SociaRegisterCubit get(context) => BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  void UserRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
        );
      },
    ).catchError(
      (e) {
        emit(SocialRegisterErroeState(e.toString()));
      },
    );
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      bio: 'write your bio ...............',
      imageCover:
          'https://production-alahly.s3.us-east-2.amazonaws.com/Article/original/DSC_6712-5f6ba17467910.JPG',
      image:
          'https://production-alahly.s3.us-east-2.amazonaws.com/Article/original/DSC_6712-5f6ba17467910.JPG',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError) {
      emit(SocialCreateUserErroeState(onError.toString()));
    });
  }
}
