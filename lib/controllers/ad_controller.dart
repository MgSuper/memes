import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/helper/ad_helper.dart';

const int maxFailedLoadAttempt = 3;

class AdController extends GetxController {
  final FirestoreController firestoreController = Get.find();
  @override
  void onInit() {
    super.onInit();
    loadInterstitialAd();
    // loadBannerAd();
    // loadRewardedAd();
  }

  @override
  void onClose() {
    super.dispose();

    interstitialAd?.dispose();
  }

  InterstitialAd? interstitialAd;
  int interstitialLoadAttempts = 0;

  // late BannerAd bannerAd;
  // RxBool isAdLoaded = false.obs;

  // RewardedAd? rewardedAd;
  // RxBool isRewardedAdReady = false.obs;

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        loadInterstitialAd();
        firestoreController.updatePointAndRank();
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
          interstitialAd = ad;
          interstitialLoadAttempts = 0;
          //
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

  // void loadRewardedAd() {
  //   RewardedAd.load(
  //     adUnitId: AdHelper.rewardedAdUnitId,
  //     request: AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         this.rewardedAd = ad;

  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //             isRewardedAdReady.value = false;
  //             firestoreController.updatePoint();
  //             update();
  //             loadRewardedAd();
  //           },
  //         );
  //         isRewardedAdReady.value = true;
  //         update();
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load a rewarded ad: ${err.message}');
  //         isRewardedAdReady.value = false;
  //         update();
  //       },
  //     ),
  //   );
  // }

  // loadBannerAd() {
  //   bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: AdHelper.bannerAdUnitId,
  //       listener: BannerAdListener(
  //           onAdLoaded: (ad) {
  //             isAdLoaded.value = true;
  //             update();
  //           },
  //           onAdFailedToLoad: (ad, error) {}),
  //       request: AdRequest());
  //   update();
  //   bannerAd.load();
  // }
}
