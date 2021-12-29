import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:memes/controllers/firebase_controller.dart';
import 'package:memes/controllers/chip_controller.dart';
import 'package:memes/models/photo.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
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
      appBar: AppBar(
        title: Text('Memes'),
        actions: [
          IconButton(
              onPressed: () {
                // this icon button is for the user to signout
                // AuthController.authInstance.signOut();
                Get.toNamed('/profile');
              },
              icon: const Icon(Icons.person))
        ],
      ),
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
                            chipController.selectedChip =
                                selected ? index : null;
                            firestoreController.onInit();
                            firestoreController.getPhotos(
                                PhotoTypes.values[chipController.selectedChip]);
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
                  itemCount: firestoreController.photoList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 5
                        : 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.15,
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
                            Get.toNamed('/detail',
                                arguments:
                                    firestoreController.photoList[index]);
                          },
                          child: Image.network(
                            firestoreController.photoList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 3.5,
                          top: 120.0,
                          child: Container(
                            width: widthValue,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(90),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        firestoreController
                                            .photoList[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    firestoreController
                                        .photoList[index].category,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
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

  _displayDialog(BuildContext context, photoDetail) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: photoDetail.name,
            child: Image.network(
              photoDetail.imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        );
      },
    );
  }
}
