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
  final _ad = Get.find<AdController>();
  final _locale = Get.find<LocaleController>();
  final _clickCtrl = Get.find<ClickController>();

  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  List<Widget> currentTab = [
    HomeScreen(),
    UserRanksScreen(),
    ProfileScreen(),
  ];

  final _inactiveColor = Colors.grey;
  @override
  void didChangeDependencies() {
    _loadBannerAd();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  _loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _isAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      request: AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomTabBarController>(
      init: BottomTabBarController(),
      builder: (controller) {
        return Scaffold(
          persistentFooterButtons: [
            // Obx(
            //   () =>
            _isAdLoaded == true
                ? Container(
                    child: AdWidget(
                      ad: _bannerAd,
                    ),
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox(),
            // ),
          ],
          floatingActionButton: Obx(
            () => _ad.isRewardedAdReady.value == true
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Reward Ad',
                        titleStyle: const TextStyle(color: Colors.teal),
                        middleText: 'Watch an Ad to get a reward !',
                        middleTextStyle: const TextStyle(color: Colors.black),
                        textConfirm: 'Ok',
                        textCancel: 'Cancel',
                        cancelTextColor: Colors.grey,
                        confirmTextColor: Colors.white,
                        buttonColor: Colors.teal,
                        onConfirm: () {
                          if (_clickCtrl.checkClickedCount()) {
                            _ad.rewardedAd?.show(
                              onUserEarnedReward:
                                  (RewardedAd ad, RewardItem reward) {
                                _firestore.updatePointAndRank();
                                Get.back();
                              },
                            );
                          } else {
                            Get.snackbar(
                              "Sorry",
                              "You have reached the click limit for this day. Please come back later.",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        onCancel: () {},
                      );
                    },
                    label: Text(
                      'get_reward'.tr,
                      style: _locale.getLocale() == 'MM'
                          ? kMyanmarFont
                          : kEnglishFont,
                    ),
                    icon: Icon(Icons.card_giftcard, size: 18),
                  )
                : SizedBox(),
          ),
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
