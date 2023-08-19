import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/commponent/component.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../search/search_sceen.dart';

class HomeSocialScreen extends StatelessWidget {
  const HomeSocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              // style: const TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.blue),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigatorTo(context, const SearchScreen());
                },
                icon: const Icon(FontAwesomeIcons.magnifyingGlass),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.facebookMessenger),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.rocketchat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.upload),
                label: 'Upoload',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.users),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.gear),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
