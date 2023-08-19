import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit_regestier/state_register.dart';
import 'package:socialapp/modules/home/home_screen.dart';

import '../../commponent/component.dart';
import '../../cubit/cubit_regestier/cubit_register.dart';
import 'login.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({super.key});

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SociaRegisterCubit(),
      child: BlocConsumer<SociaRegisterCubit, SociaRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigatorAndFinish(context, const HomeSocialScreen());
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
                        'Register',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Register now to browse our fooers',
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
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.email,
                          ),
                          hintText: 'name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
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
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your phone';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.lock,
                          ),
                          hintText: 'phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadState,
                        builder: (context) {
                          return Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  SociaRegisterCubit.get(context).UserRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                                print(emailController.text);
                                print(passwordController.text);
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
                          const Text('are you have account?'),
                          defultTextButton(
                            function: () {
                              navigatorTo(context, SocialLoginScreen());
                            },
                            text: 'Login',
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
