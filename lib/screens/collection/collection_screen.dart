import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/screens/profile/profile_controller.dart';

class CollectionScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Number of Users : ",
                style: TextStyle(fontSize: 20),
              ),
              Obx(
                () => Text(
                  controller.count.value.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
