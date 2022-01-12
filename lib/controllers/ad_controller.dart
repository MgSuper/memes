import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/helper/ad_helper.dart';

const int maxFailedLoadAttempt = 3;

class AdController extends GetxController {
  @override
  void onInit() {
    createBottomBannerAd();
    loadInterstitialAd();
    loadRewardedAd();
  }

  ///------------------  Dispose
  @override
  void onClose() {
    bannerAd.dispose();
    interstitialAd?.dispose();
    rewardedAd.dispose();
    super.onClose();
  }

  ///----------------------------------- Banner Ad
  late BannerAd bannerAd;
  InterstitialAd? interstitialAd;
  late RewardedAd rewardedAd;

  int interstitialLoadAttempts = 0;

  final isBannerLoaded = false.obs;
  final isRewardedAdReady = false.obs;

  bool bannerAdError = false;
  AdWidget? bannerAdWidget;

  void createBottomBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerLoaded.value = true;
          update();
          print('BAD: $isBannerLoaded');
        },
        onAdFailedToLoad: (ad, error) {
          bannerAdError = false;
          ad.dispose();
          print('ADERROR: $error');
          update();
        },
      ),
    );
    update();
    bannerAd.load();
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitialAd();
        update();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError err) {
        ad.dispose();
        loadInterstitialAd();
        update();
      });
      update();
      interstitialAd!.show();
    }
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          this.interstitialAd = ad;
          interstitialLoadAttempts = 0;
          update();
        },
        onAdFailedToLoad: (LoadAdError err) {
          interstitialLoadAttempts += 1;
          interstitialAd = null;
          if (interstitialLoadAttempts >= maxFailedLoadAttempt) {
            loadInterstitialAd();
            update();
          }
        },
      ),
    );
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              isRewardedAdReady.value = false;
              update();
              loadRewardedAd();
            },
          );
          isRewardedAdReady.value = true;
          update();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          isRewardedAdReady.value = false;
          update();
        },
      ),
    );
  }

  /// --------------------------  Inline Banner Ad
  // final adIndex = 2;

  //
  // int getDestinationItemIndex({int? rawIndex}) {
  //   if (rawIndex! >= adIndex && isBannerLoaded.value) {
  //     return rawIndex - 1;
  //   }
  //   return rawIndex;
  // }
}
