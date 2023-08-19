import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';
import 'package:socialapp/modules/home/home_screen.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';
import 'package:socialapp/shared/style/theme.dart';

import 'commponent/constans/constans.dart';
import 'cubit/bloc_ofser.dart';
import 'modules/login_register/login.dart';

Future<void> main() async {
  Widget? widget;
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  await CacheHelper.cascheInitialization();
  uId = CacheHelper.getData(key: 'uId');
  print(' the uid is  ${uId.toString()}');
  // ignore: unnecessary_null_comparison
  if (uId != null) {
    widget = HomeSocialScreen();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  // final String

  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()
              ..getPostsComuntIndex()
            // ..getComments(),
            )
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
