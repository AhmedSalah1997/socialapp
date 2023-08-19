import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/commponent/component.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';

import '../../models/model_social_app.dart';
import '../../shared/style/color.dart';
import '../chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return bulidChatItem(
                    context, SocialCubit.get(context).users[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              itemCount: SocialCubit.get(context).users.length,
            );
          },
          condition: SocialCubit.get(context).users.isNotEmpty,
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
      listener: (context, state) {},
    );
  }

  Widget bulidChatItem(BuildContext context, SocialUserModel model) {
    return InkWell(
      onTap: () {
        navigatorTo(
            context,
            ChatDetailsScreen(
              model: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
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
                      // const Icon(
                      //   Icons.check_circle,
                      //   size: 16.0,
                      //   color: defultolor,
                      // )
                    ],
                  ),
                  // Text(
                  //   model.date,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodySmall!
                  //       .copyWith(height: 1.4),
                  // ),
                ],
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.more_horiz,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
