import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/constants/style.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/models/models.dart';
import 'package:memes/presentation/screens/home/home_controller.dart';
import 'package:memes/presentation/screens/view_photo/view_photo.dart';

class HomeScreen extends StatelessWidget {
  final _firestore = Get.find<FirestoreController>();
  final _chip = Get.find<ChipController>();
  final _ad = Get.find<AdController>();
  final _locale = Get.find<LocaleController>();
  final _ctrl = Get.find<HomeController>();

  final List<String> _chipLabel = [
    'show_all',
    'memes',
    'cartoons',
    'gaming',
    'programming',
  ];

  HomeScreen({Key? key}) : super(key: key) {
    _ad.inlineBannerAd.dispose();
    _ad.inlineBannerAd.load();
  }
  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / 2.2;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => SizedBox(
                height: 50.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Wrap(
                      spacing: 5.0,
                      children: List<Widget>.generate(5, (int index) {
                        return ChoiceChip(
                          selectedColor: Colors.teal,
                          backgroundColor: Colors.grey,
                          label: Text(
                            _chipLabel[index].tr,
                            style: _locale.getLocale() == 'MM'
                                ? kMyanmarFont
                                : kEnglishFont,
                          ),
                          selected: _chip.selectedChip == index,
                          onSelected: (bool selected) {
                            _chip.selectedChip = selected ? index : null;
                            _firestore.onInit();
                            _firestore.getPhotos(
                                PhotoTypes.values[_chip.selectedChip]);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemCount: _firestore.photoList.length +
                      (_ad.isInlineBannerAdLoaded.value == true ? 1 : 0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 5
                        : 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    if (_ad.isInlineBannerAdLoaded.value == true &&
                        index == _ad.inlineIndex.value) {
                      return Container(
                        width: _ad.inlineBannerAd.size.width.toDouble(),
                        height: _ad.inlineBannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _ad.inlineBannerAd),
                      );
                    } else {
                      final photo =
                          _firestore.photoList[_ad.getCorrectIndex(index)];
                      return InkWell(
                        onTap: () {
                          _ctrl.timer.value = 3;
                          _ctrl.runTimer();
                          Get.defaultDialog(
                            title: 'Watch an Ad to get a reward !',
                            content: Center(
                              child: Obx(
                                () => Text(
                                    'Video starting in ${_ctrl.timer.value}'),
                              ),
                            ),
                          ).then(
                            (value) {
                              print(value);
                              if (value == null) {
                                _ad.rewardedAd?.show(
                                  onUserEarnedReward:
                                      (RewardedAd ad, RewardItem reward) {
                                    _firestore.updatePointAndRank();
                                  },
                                ).then(
                                  (value) => Get.to(() => ViewPhoto(),
                                      arguments: {'image': photo.imageUrl},
                                      transition: Transition.fadeIn),
                                );
                              }
                            },
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: photo.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[300]!,
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                  child: const CircularProgressIndicator(
                                strokeWidth: 1,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(100)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      photo.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      photo.category,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
