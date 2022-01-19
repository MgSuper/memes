import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/models/models.dart';
import 'package:memes/screens/view_photo/view_photo.dart';

class HomeScreen extends StatelessWidget {
  final _firestore = Get.find<FirestoreController>();
  final _chip = Get.find<ChipController>();
  final _ad = Get.find<AdController>();

  final List<String> _chipLabel = [
    'show_all',
    'memes',
    'cartoons',
    'celebrities',
  ];

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
                      children: List<Widget>.generate(4, (int index) {
                        return ChoiceChip(
                          label: Text(_chipLabel[index].tr),
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
                  itemCount: _firestore.photoList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 5
                        : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return InkWell(
                      onTap: () {
                        _ad.showInterstitialAd();
                        Get.to(() => const ViewPhoto(),
                            arguments: {
                              'image': _firestore.photoList[index].imageUrl
                            },
                            transition: Transition.fadeIn);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: _firestore.photoList[index].imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter: const ColorFilter.mode(
                                  //   Colors.grey,
                                  //   BlendMode.colorBurn,
                                  // ),
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
                                    _firestore.photoList[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _firestore.photoList[index].category,
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
