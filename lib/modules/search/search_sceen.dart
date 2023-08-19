import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/stats.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        var searchModel = SocialCubit.get(context).userModel;
        // var textController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              // controller: textController,
              autofocus: true,
              onChanged: (value) {
                SocialCubit.get(context).searchUser(
                  nameSerach: value.toString(),
                );
              },
            ),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: Text(searchModel!.name),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox();
            },
            itemCount: SocialCubit.get(context).searchModel.length,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
