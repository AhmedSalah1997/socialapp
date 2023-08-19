import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/commponent/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';
import 'package:socialapp/modules/edit_profile/edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModle = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                  userModle!.imageCover,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      height: 110.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.5),
                        shape: BoxShape.circle,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            userModle.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Text(userModle.name,
                  style: Theme.of(context).textTheme.bodyMedium),
              Text(userModle.bio, style: Theme.of(context).textTheme.bodySmall),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text('Posts',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('5',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text('Photos',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('20',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text('Followers',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('58',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text('Following',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('EDIT PROFILE'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  OutlinedButton(
                    onPressed: () {
                      navigatorTo(context, EditProfileScreen());
                    },
                    child: const Icon(
                      FontAwesomeIcons.userPen,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
