import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/constants/style.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/screens/home/home_screen.dart';
import 'package:memes/presentation/screens/profile/profile_screen.dart';
import 'package:memes/presentation/screens/user_ranks/user_ranks.dart';
import 'package:memes/utils/helper/ad_helper.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  final _firestore = Get.find<FirestoreController>();
  final _locale = Get.find<LocaleController>();

  List<Widget> currentTab = [
    HomeScreen(),
    UserRanksScreen(),
    ProfileScreen(),
  ];

  final _inactiveColor = Colors.grey;
  @override
  void dispose() {
    super.dispose();
  }

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
                UserRanksScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: controller.tabIndex,
            selectedItemColor: Colors.teal,
            onTap: controller.changeTabIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.run_circle),
                label: 'ranks'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'profile'.tr,
              ),
            ],
          ),
        );
      },
    );
  }
}
