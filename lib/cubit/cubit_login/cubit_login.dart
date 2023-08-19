import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit_login/state_login.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoigninitalState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoignLoadState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      emit(SocialLoignSuccessState(value.user!.uid));
    }).catchError((e) {
      emit(SocialLoignErroeState(e.toString()));
    });
  }
}
