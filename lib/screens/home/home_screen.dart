import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/color.dart';
import 'package:memes/controllers/chip_controller.dart';
import 'package:memes/controllers/firestore_controller.dart';
import 'package:memes/models/photo.dart';
import 'package:memes/screens/view_photo/view_photo.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreController firestoreController = Get.put(FirestoreController());
  final ChipController chipController = Get.put(ChipController());

  //name of chips given as list
  final List<String> _chipLabel = [
    'SHOW ALL',
    'MEMES',
    'CARTOONS',
    'CELEBRITIES',
    'OHNO',
  ];
  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / 2.2;
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
                          label: Text(_chipLabel[index]),
                          selected: chipController.selectedChip == index,
                          onSelected: (bool selected) {
                            chipController.selectedChip = selected ? index : null;
                            firestoreController.onInit();
                            firestoreController.getPhotos(PhotoTypes.values[chipController.selectedChip]);
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
                  itemCount: firestoreController.photoList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 5 : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        InkWell(
                          onTap: () {
                            // _displayDialog(
                            //     context, firestoreController.photoList[index]);
                            // Get.toNamed('/detail',
                            //     arguments:
                            //         firestoreController.photoList[index]);
                            Get.to(() => const ViewPhoto(), arguments: {'image': firestoreController.photoList[index].imageUrl}, transition: Transition.fadeIn);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                            child: CachedNetworkImage(
                              imageUrl: firestoreController.photoList[index].imageUrl,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.grey,
                                      BlendMode.colorBurn,
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                  child: const CircularProgressIndicator(
                                strokeWidth: 1,
                              )),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)), color: Colors.black.withAlpha(90)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  firestoreController.photoList[index].name,
                                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  firestoreController.photoList[index].category,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
