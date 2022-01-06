import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/color.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar_controller.dart';
import 'package:memes/screens/collection/collection_screen.dart';
import 'package:memes/screens/home/home_screen.dart';
import 'package:memes/screens/profile/profile_screen.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;
  List<Widget> currentTab = [
    HomeScreen(),
    CollectionScreen(),
    ProfileScreen(),
  ];

  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomTabBarController>(
      init: BottomTabBarController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeScreen(),
                CollectionScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: kBackgroundColor,
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.run_circle),
                label: 'Ranks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
