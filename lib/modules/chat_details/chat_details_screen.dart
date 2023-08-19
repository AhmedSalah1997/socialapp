import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';
import 'package:socialapp/models/message.dart';
import 'package:socialapp/models/model_social_app.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel model;
  const ChatDetailsScreen({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receierId: model.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: const Color(0xff121B22),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 20,
                        color: Color(0xffffffff),
                      )),
                ],
                backgroundColor: const Color(0xff202C33),
                titleSpacing: 0,
                title: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Color(0xffffffff),
                        )),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(model.image),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Text(
                        '+201022092102',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffFFFFFF),
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.video,
                          size: 20,
                          color: Color(0xffffffff),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.call,
                          size: 23,
                          color: Color(0xffffffff),
                        )),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        builder: (context) {
                          return ListView.separated(
                            // reverse: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // var message =
                              //     SocialCubit.get(context).messgaes[index];
                              // if (SocialCubit.get(context).userModel!.uId ==
                              //     message.sendId) {
                              //   return myMessage(
                              //     // context,
                              //     message,
                              //   );
                              // } else {
                              //   return bulidMessage(
                              //     // context,
                              //     message,
                              //   );
                              // }
                              return Column(
                                children: [
                                  bulidMessage(
                                      context: context,
                                      text: 'السلام عليكم ازيك يا احمد',
                                      time: '14:05'),
                                  // bulidMessage(''),
                                  myMessage(
                                      context: context,
                                      text: 'الحمد لله بخير مين ؟',
                                      time: '14:07'),
                                  bulidMessage(
                                    context: context,
                                    text:
                                        'أنا المهندسة نيرة عطية اللى كنت معاك في الكلية',
                                    time: '14:07',
                                  ),
                                  myMessage(
                                    context: context,
                                    text: 'ازيك يبشمهندسة أخبارك ايه ؟',
                                    time: '14:08',
                                  ),
                                  bulidMessage(
                                    context: context,
                                    text:
                                        'الحمد لله انا بعزمك على فرحي ان شاء الله ',
                                    time: '14:08',
                                  ),
                                  bulidMessage(
                                    context: context,
                                    text: 'تيجي انت واحمد حسام ',
                                    time: '14:08',
                                  ),
                                  bulidMessage(
                                    context: context,
                                    text: 'هيبقي عارف المكان وكدا تيجي معاه',
                                    time: '14:08',
                                  ),
                                  bulidMessage(
                                    context: context,
                                    text: 'انا عارفه ان فرحه كان قريب ',
                                    time: '14:09',
                                  ),
                                  myMessage(
                                    context: context,
                                    text: 'اه هوا لسه متجوز قريب',
                                    time: '14:10',
                                  ),
                                  bulidMessage(
                                    context: context,
                                    text:
                                        'ربنا يسعده عارفه ان هوا بيخاف من مراته وممكن ميجيش',
                                    time: '14:10',
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: 1,
                          );
                        },
                        condition: SocialCubit.get(context).messgaes.isNotEmpty,
                        fallback: (context) =>
                            const Center(child: Text('Start Chat Now')),
                      ),
                    ),
                    ButtonSendMessage(
                        textController: textController, model: model)
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

  Widget bulidMessage({
    required String text,
    required String time,
    required BuildContext context,
  }
      // MesseageModel message
      ) {
    // Timestamp timestamp = message.dateTime as Timestamp;
    // final DateTime dateTime = timestamp.toDate();
    // final dateString = DateFormat('K:mm:ss').format(dateTime);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          margin: const EdgeInsets.only(
            left: 8,
            top: 3,
            // bottom: 2,
          ),
          // margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
              color: Color(0xff1F2C34),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text.toString(),
                // message.text,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  time.toString(),
                  // message.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white, fontSize: 11),
                ),
              ),
              // Text(dateString),
            ],
          )),
    );
  }

  Widget myMessage({
    required String text,
    required String time,
    required BuildContext context,
  }
      // MesseageModel message
      ) {
    // DateTime myDateTime = (message.dateTime).toDate();
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          right: 8,
          top: 10,
          bottom: 10,
        ),
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: Color(0xff005C4D),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text.toString(),
              // message.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            // Text(message.dateTime),
            // Text(
            //   message.dateTime,
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodySmall!
            //       .copyWith(color: Colors.white, fontSize: 12),
            // ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Text(
                    time.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white, fontSize: 11),
                  ),
                  Container(
                    // width: 50,
                    // height: 50,
                    child: const Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.check,
                            color: Color(0xff62C7E3),
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check,
                          color: Color(0xff62C7E3),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //     Align(
    //   alignment: Alignment.centerLeft,
    //   child: Container(
    //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
    //       decoration: const BoxDecoration(
    //           color: Colors.green,
    //           borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(8.0),
    //             topLeft: Radius.circular(8.0),
    //             bottomRight: Radius.circular(8.0),
    //           )),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Text(message.text),
    //           Text(
    //             message.text,
    //             style: Theme.of(context).textTheme.bodySmall,
    //           ),
    //         ],
    //       )),
    // );
  }
}

class ButtonSendMessage extends StatelessWidget {
  const ButtonSendMessage({
    super.key,
    required this.textController,
    required this.model,
  });

  final TextEditingController textController;
  final SocialUserModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: const Color(0xff202C33),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        size: 22,
                        FontAwesomeIcons.solidFaceGrinWide,
                        color: Colors.white.withOpacity(.5),
                      )),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        if (value != '') {
                          print(value);
                          SocialCubit.get(context).commetSend(true);
                        }
                      },
                      controller: textController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Message ',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(
                            color: Color(0xffFFFFFF),
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.paperclip,
                        size: 21,
                        color: Colors.white.withOpacity(.5),
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        size: 25,
                        Icons.camera_alt_rounded,
                        color: Colors.white.withOpacity(.5),
                      )),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SocialCubit.get(context).isShow == false
            ? const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xff00AA84),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                ),
              )
            : CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xff00AA84),
                child: IconButton(
                  onPressed: () {
                    SocialCubit.get(context).sendMeaasge(
                      receierId: model.uId,
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                    textController.clear();
                    SocialCubit.get(context).commetSend(false);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
      ],
    );
  }
}
