import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/shared/style/color.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModle = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverfileImage = SocialCubit.get(context).coverImage;
        nameController.text = userModle!.name;
        bioController.text = userModle.bio;
        phoneController.text = userModle.phone;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUserData(
                      bio: bioController.text,
                      name: nameController.text,
                      phone: phoneController.text,
                    );
                  },
                  child: const Text('upgrade'),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUploadLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUploadLoadingState)
                    const SizedBox(
                      height: 30,
                    ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              coverfileImage == null
                                  ? Container(
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                userModle.imageCover,
                                              ),
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(coverfileImage.path)),
                                              fit: BoxFit.cover)),
                                    ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: defultolor,
                                  child: Icon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //  ? FileImage(File(profileImage.path))
                        //           : ImageProvider(NetworkImage(userModle.image)),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            profileImage == null
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userModle.image),
                                    radius: 65,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    radius: 65,
                                    backgroundImage:
                                        FileImage(File(profileImage.path)),
                                  ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 15,
                                backgroundColor: defultolor,
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  // color: Colors.blue,
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: const Text('Upload Profile Image'),
                                ),
                                // if (state is SocialUploadLoadingState)
                                //   const SizedBox(
                                //     height: 5.0,
                                //   ),
                                // if (state is SocialUploadLoadingState)
                                //   const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SocialCubit.get(context).cover(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: const Text('Upload Cover Image'),
                                ),
                                // if (state is SocialUploadLoadingState)
                                //   const SizedBox(
                                //     height: 5.0,
                                //   ),
                                // if (state is SocialUploadLoadingState)
                                //   const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 30,
                    ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.person,
                      ),
                      hintText: 'name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: bioController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your bio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.laptop_windows_rounded,
                      ),
                      hintText: 'bio',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your phone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.laptop_windows_rounded,
                      ),
                      hintText: 'phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
