import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar_controller.dart';
import 'package:memes/screens/user_ranks/user_ranks.dart';
import 'package:memes/screens/home/home_screen.dart';
import 'package:memes/screens/profile/profile_screen.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  final AdController _adController = Get.put(AdController());
  int _currentIndex = 0;
  List<Widget> currentTab = [
    HomeScreen(),
    UserRanksScreen(),
    ProfileScreen(),
  ];

  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomTabBarController>(
      init: BottomTabBarController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: _adController.isRewardedAdReady == true
              ? FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Need a hint?'),
                          content: Text('Watch an Ad to get a hint!'),
                          actions: [
                            TextButton(
                              child: Text('cancel'.toUpperCase()),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('ok'.toUpperCase()),
                              onPressed: () {
                                Navigator.pop(context);
                                _adController.rewardedAd.show(
                                    onUserEarnedReward:
                                        (RewardedAd ad, RewardItem reward) {});
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  label: Text('Point'),
                  icon: Icon(Icons.card_giftcard),
                )
              : null,
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
            // backgroundColor: kBackgroundColor,
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
