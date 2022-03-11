import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/utils/helper/ad_helper.dart';

const int maxFailedLoadAttempt = 3;

class AdController extends GetxController {
  final _firestore = Get.find<FirestoreController>();

  InterstitialAd? interstitialAd;
  int interstitialLoadAttempts = 0;

  RewardedAd? rewardedAd;
  RxBool isRewardedAdReady = false.obs;

  RxInt inlineIndex = 0.obs;
  late BannerAd inlineBannerAd;
  RxBool isInlineBannerAdLoaded = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadRewardedAd();
    createInlineBannerAd();
  }

  @override
  void onClose() {
    super.dispose();
    interstitialAd?.dispose();
    rewardedAd?.dispose();
    inlineBannerAd.dispose();
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

  void createInlineBannerAd() {
    inlineBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isInlineBannerAdLoaded.value = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          update();
        },
      ),
    );
    inlineBannerAd.load();
  }

  int getCorrectIndex(int index) {
    if (index >= inlineIndex.value && isInlineBannerAdLoaded.value == true) {
      return index - 1;
    }
    return index;
  }
}
