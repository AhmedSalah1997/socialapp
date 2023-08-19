import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/modules/home/home_screen.dart';
import 'package:socialapp/modules/login_register/register.dart';

import '../../commponent/component.dart';
import '../../commponent/constans/constans.dart';
import '../../cubit/cubit_login/cubit_login.dart';
import '../../cubit/cubit_login/state_login.dart';
import '../../shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoignErroeState) {
            showTost(text: state.error);
          }
          if (state is SocialLoignSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              uId = state.uId;
              debugPrint(' the uid for users is ${uId.toString()}');
              SocialCubit.get(context).getUserData();
              // SocialCubit.get(context).getPosts();
              navigatorAndFinish(context, const HomeSocialScreen());

              print(state.uId);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Login noe to this app',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.email,
                          ),
                          hintText: 'email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.lock,
                          ),
                          hintText: 'password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoignLoadState,
                        builder: (context) {
                          return Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                              ),
                              onPressed: () {
                                print(emailController.text);
                                print(passwordController.text);
                                if (_formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                          );
                        },
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('don\'t have account?'),
                          defultTextButton(
                            function: () {
                              navigatorTo(context, SocialRegisterScreen());
                            },
                            text: 'SingUp',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
