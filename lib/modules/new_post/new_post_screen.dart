import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';

class NewPoatScreen extends StatelessWidget {
  const NewPoatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          textController.clear();
          SocialCubit.get(context).removePostImage();
        }
      },
      builder: (context, state) {
        var userModle = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    profileImage == null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(userModle!.image),
                            radius: 30,
                          )
                        : CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 30,
                            backgroundImage: FileImage(File(profileImage.path)),
                          ),
                    const SizedBox(width: 10.0),
                    Text(userModle!.name),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (SocialCubit.get(context).postImage != null)
                  SizedBox(
                    height: 190,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                    image: FileImage(File(
                                        SocialCubit.get(context)
                                            .postImage!
                                            .path)),
                                    fit: BoxFit.cover)),
                          ),
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(FontAwesomeIcons.image),
                            // SizedBox(
                            //   width: 5.0,
                            // ),
                            Text('# tages'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (SocialCubit.get(context).postImage == null) {
                SocialCubit.get(context).createPost(
                  date: DateTime.now().toString(),
                  text: textController.text,
                );
              } else {
                SocialCubit.get(context).uploadePostImage(
                  date: DateTime.now().toString(),
                  text: textController.text,
                );
              }
            },
          ),
        );
      },
    );
  }
}
