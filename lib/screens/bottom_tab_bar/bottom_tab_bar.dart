import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/helper/ad_helper.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar_controller.dart';
import 'package:memes/screens/user_ranks/user_ranks.dart';
import 'package:memes/screens/home/home_screen.dart';
import 'package:memes/screens/profile/profile_screen.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  // final AdController _adController = Get.put(AdController());
  final FirestoreController _firestoreController = Get.find();
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  RewardedAd? _rewardedAd;
  bool _isRewardedAdReady = false;
  int _currentIndex = 0;

  List<Widget> currentTab = [
    HomeScreen(),
    UserRanksScreen(),
    ProfileScreen(),
  ];

  final _inactiveColor = Colors.grey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _adController.loadRewardedAd();
    // _adController.loadBannerAd();
    _loadBannerAd();
    _loadRewardedAd();
  }

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    _bannerAd.dispose();
    _rewardedAd?.dispose();
    // _adController.loadRewardedAd();
    // _adController.loadBannerAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _firestoreController.updatePointAndRank();
              // update();
              _loadRewardedAd();
            },
          );
          setState(() {
            _isRewardedAdReady = true;
          });

          // update();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });

          // update();
        },
      ),
    );
  }

  _loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isAdLoaded = true;
        });
        // update();
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      request: AdRequest(),
    );
    // update();
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
          floatingActionButton:
              // Obx(
              //   () =>
              _isRewardedAdReady == true
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Need a point?'),
                              content: Text('Watch an Ad to get a point!'),
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
                                    _rewardedAd?.show(
                                        onUserEarnedReward: (RewardedAd ad,
                                            RewardItem reward) {});
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
                  : SizedBox(),
          // ),
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
