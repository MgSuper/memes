import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/firestore_controller.dart';
import 'package:memes/screens/profile/profile_controller.dart';

class CollectionScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rank List",
                style: TextStyle(fontSize: 20),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: firestoreController.userList.length,
                    itemBuilder: (context, index) {
                      print(firestoreController.userList[index].name);
                      return ListTile(
                        title: Text(firestoreController.userList[index].name),
                        subtitle:
                            Text(firestoreController.userList[index].point),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
