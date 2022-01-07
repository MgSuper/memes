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
      backgroundColor: Colors.white,
      body:
          // Obx(
          //   () => Expanded(
          //     child: ListView.builder(
          //       itemCount: firestoreController.userList.length,
          //       itemBuilder: (context, index) {
          //         print(firestoreController.userList[index].name);
          //         return ListTile(
          //           title: Text(firestoreController.userList[index].name),
          //           subtitle:
          //               Text(firestoreController.userList[index].point),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Text('User Ranks'),
          ListTile(
            title: Text("Battery Full"),
            subtitle: Text("The battery is full."),
            leading: CircleAvatar(child: Text('AH')),
          ),
          ListTile(
            title: Text("Anchor"),
            subtitle: Text("Lower the anchor."),
            leading: CircleAvatar(child: Text('AH')),
          ),
          ListTile(
            title: Text("Alarm"),
            subtitle: Text("This is the time."),
            leading: CircleAvatar(child: Text('AH')),
          ),
          ListTile(
            title: Text("Ballot"),
            subtitle: Text("Cast your vote."),
            leading: CircleAvatar(child: Text('AH')),
          )
        ],
      ),
    );
  }
}
