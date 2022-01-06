import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhoto extends StatelessWidget {
  const ViewPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: PhotoView(
                      initialScale: PhotoViewComputedScale.contained,
                      tightMode: true,
                      filterQuality: FilterQuality.high,
                      imageProvider: NetworkImage(Get.arguments['image'] ?? ''),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.offAll(() => BottomTabBar(),
                            transition: Transition.fadeIn);
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
