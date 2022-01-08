import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/color.dart';
import 'package:memes/controllers/firestore_controller.dart';
import 'package:memes/screens/profile/profile_controller.dart';

class CollectionScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final FirestoreController firestoreController = Get.put(FirestoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                // fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: firestoreController.userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(firestoreController.userList[index].name),
                        subtitle: Text(firestoreController.userList[index].point),
                        leading: Text(index.toString()),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      //     ListView(
      //   padding: const EdgeInsets.all(8),
      //   children: <Widget>[
      //     Text('User Ranks'),
      //     ListTile(
      //       title: Text("Battery Full"),
      //       subtitle: Text("The battery is full."),
      //       leading: CircleAvatar(child: Text('AH')),
      //     ),
      //     ListTile(
      //       title: Text("Anchor"),
      //       subtitle: Text("Lower the anchor."),
      //       leading: CircleAvatar(child: Text('AH')),
      //     ),
      //     ListTile(
      //       title: Text("Alarm"),
      //       subtitle: Text("This is the time."),
      //       leading: CircleAvatar(child: Text('AH')),
      //     ),
      //     ListTile(
      //       title: Text("Ballot"),
      //       subtitle: Text("Cast your vote."),
      //       leading: CircleAvatar(child: Text('AH')),
      //     )
      //   ],
      // ),
    );
  }
}
