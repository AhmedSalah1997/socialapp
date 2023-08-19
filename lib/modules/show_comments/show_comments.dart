import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';

import '../../models/create_comment.dart';
import '../../models/post_model.dart';
import '../../shared/style/color.dart';

class ShowComments extends StatelessWidget {
  final PostModel model;
  final String postUid;
  final int index;

  const ShowComments({
    required this.postUid,
    required this.model,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getComments(postId: postUid);
        return BlocConsumer<SocialCubit, SocialStates>(
          builder: (context, state) {
            var userComments = SocialCubit.get(context).comments;
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(model.image),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      model.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(height: 1.4),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 16.0,
                                      color: defultolor,
                                    )
                                  ],
                                ),
                                Text(
                                  model.date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(height: 1.4),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 5.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        model.text,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 15.0),
                      // Padding(
                      //   padding: const EdgeInsetsDirectional.only(
                      //     end: 10.0,
                      //   ),
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     child: Wrap(
                      //       children: [
                      //         SizedBox(
                      //           height: 20.0,
                      //           child: MaterialButton(
                      //             height: 25.0,
                      //             minWidth: 1.0,
                      //             padding: EdgeInsets.zero,
                      //             onPressed: () {},
                      //             child: const Text(
                      //               '#software',
                      //               style: TextStyle(color: defultolor),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      if (model.image != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            height: 140.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      model.image,
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  SocialCubit.get(context).likePost(
                                      SocialCubit.get(context).postsId[index]);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.heart,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        '${SocialCubit.get(context).likes[index].toString()} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.message,
                                        size: 17,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        '${SocialCubit.get(context).commentIndex[index].toString()} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),

                      // Text(SocialCubit.get(context).comments),
                      Container(
                        // color: Colors.grey,
                        height: 250,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    userComments[index].comments.toString()),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        userComments[index].image)),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 5);
                            },
                            itemCount:
                                SocialCubit.get(context).comments.length),
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.image),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.grey,
                      height: 26,
                      margin: const EdgeInsets.all(1.0),
                      child: TextFormField(
                        // onChanged: (value) {
                        //   if (value.isNotEmpty) {
                        //     SocialCubit.get(context).commetSend(true);
                        //   }
                        // },
                        controller: textController,
                        decoration: const InputDecoration(
                            hintText: 'write a comment',
                            labelStyle: TextStyle(fontSize: 11),
                            hintStyle: TextStyle(fontSize: 11),
                            border: InputBorder.none),
                      ),
                    )),
                    // SocialCubit.get(context).isShow == true
                    // ?
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).commentPost(
                          comment: textController.text,
                          date: DateTime.now().toString(),
                          image: SocialCubit.get(context).userModel!.image,
                          name: SocialCubit.get(context).userModel!.name,
                          postId: SocialCubit.get(context).postsId[index],
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.paperPlane,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    )
                    // : const SizedBox(),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        );
      },
    );
  }
}
