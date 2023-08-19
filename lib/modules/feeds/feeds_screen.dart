import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';
import 'package:socialapp/models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(0.0),
                elevation: 10.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    // alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      // CircleAvatar(
                      //   radius: 23,
                      //   backgroundImage: NetworkImage(
                      //     SocialCubit.get(context).userModel!.image,
                      //   ),
                      // ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 35,
                          child: TextFormField(
                            decoration: InputDecoration(
                              // enabledBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(25.0),
                              //   borderSide:
                              //       const BorderSide(color: Colors.grey),
                              // ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(FontAwesomeIcons.images),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 5.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return WidgetBulidPostItem(
                    model: SocialCubit.get(context).posts[index],
                    postUid: SocialCubit.get(context).postUid,
                    index: index,
                  );
                }),
                itemCount: SocialCubit.get(context).posts.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class WidgetBulidPostItem extends StatelessWidget {
  var textController = TextEditingController();
  final PostModel model;
  final String postUid;
  final int index;
  WidgetBulidPostItem({
    required this.model,
    required this.index,
    required this.postUid,
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
                          // const SizedBox(
                          //   width: 5.0,
                          // ),
                          // const Icon(
                          //   Icons.check_circle,
                          //   size: 16.0,
                          //   color: defultolor,
                          // )
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
            //   child: Divider(
            //     height: 1,
            //     color: Colors.grey,
            //   ),
            // ),
            if (model.text != '')
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    model.text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

            // Text(
            //   model.text,
            //   style: Theme.of(context).textTheme.bodyMedium,
            // ),
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
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                          image: NetworkImage(
                            model.postImage,
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
            // if (SocialCubit.get(context).likes[index] != 0)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                if (SocialCubit.get(context).likes[index] != 0)
                  Expanded(
                    child: Text(
                      '${SocialCubit.get(context).likes[index].toString()}من الأشخاص ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                Expanded(
                  child: Text(
                    '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                if (SocialCubit.get(context).commentIndex[index] != 0)
                  Text(
                    'تعليقات  ${SocialCubit.get(context).commentIndex[index].toString()} ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                Text(
                  '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ]),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {
            //             SocialCubit.get(context)
            //                 .likePost(SocialCubit.get(context).postsId[index]);
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 5.0),
            //             child: Row(
            //               children: [
            //                 const Icon(
            //                   FontAwesomeIcons.heart,
            //                   size: 18,
            //                   color: Colors.red,
            //                 ),
            //                 const SizedBox(width: 5.0),
            //                 Text(
            //                   '${SocialCubit.get(context).likes[index].toString()} ',
            //                   style: Theme.of(context).textTheme.bodySmall,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {
            //             navigatorTo(
            //                 context,
            //                 ShowComments(
            //                   index: index,
            //                   model: model,
            //                   postUid:
            //                       (SocialCubit.get(context).postsId[index]),
            //                 ));
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 5.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 const Icon(
            //                   FontAwesomeIcons.message,
            //                   size: 17,
            //                   color: Colors.blue,
            //                 ),
            //                 const SizedBox(width: 5.0),
            //                 Text(
            //                   '${SocialCubit.get(context).commentIndex[index].toString()} ',
            //                   style: Theme.of(context).textTheme.bodySmall,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).likePost(
                                SocialCubit.get(context).postsId[index]);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.thumbsUp,
                            size: 20,
                          )),
                      Text(
                        'أعجبني',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  // CircleAvatar(
                  //   radius: 15.0,
                  //   backgroundImage:
                  //       NetworkImage(SocialCubit.get(context).userModel!.image),
                  // ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.message,
                            size: 20,
                          )),
                      Text(
                        'تعليق',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  // CircleAvatar(
                  //   radius: 15.0,
                  //   backgroundImage:
                  //       NetworkImage(SocialCubit.get(context).userModel!.image),
                  // ),
                  // const SizedBox(
                  //   width: 15,
                  // ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.paperPlane,
                            size: 20,
                          )),
                      Text(
                        'ارسال',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  // Expanded(
                  //     child: Container(
                  //   height: 26,
                  //   margin: const EdgeInsets.all(1.0),
                  //   child: TextFormField(
                  //     // onChanged: (value) {
                  //     //   if (value.isNotEmpty) {
                  //     //     SocialCubit.get(context).commetSend(true);
                  //     //   }
                  //     // },
                  //     controller: textController,
                  //     decoration: const InputDecoration(
                  //       hintText: 'write a comment',
                  //       labelStyle: TextStyle(fontSize: 11),
                  //       hintStyle: TextStyle(fontSize: 11),
                  //       border: InputBorder.none,
                  //     ),
                  //   ),
                  // )),
                  // SocialCubit.get(context).isShow == true
                  // ?
                  // InkWell(
                  //   onTap: () {
                  //     SocialCubit.get(context).commentPost(
                  //       comment: textController.text,
                  //       date: DateTime.now().toString(),
                  //       image: SocialCubit.get(context).userModel!.image,
                  //       name: SocialCubit.get(context).userModel!.name,
                  //       postId: SocialCubit.get(context).postsId[index],
                  //     );
                  //   },
                  //   child: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Icon(
                  //         FontAwesomeIcons.paperPlane,
                  //         size: 20,
                  //         color: Colors.blue,
                  //       ),
                  //     ],
                  //   ),
                  // )
                  // : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
