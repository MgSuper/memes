import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/widgets/widgets.dart';
import '../../controllers/firestore_controller.dart';
import '../profile/profile_controller.dart';

class UserRanksScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: firestoreController.userList.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Card(
                        child: RankListTile(
                            title: firestoreController.userList[index].name,
                            sub_title: firestoreController.userList[index].rank,
                            index: index,
                            trailing: firestoreController.userList[index].point,
                            rank_color: Colors.amber[600]),
                      );
                    } else if (index == 1) {
                      return Card(
                        child: RankListTile(
                            title: firestoreController.userList[index].name,
                            sub_title: firestoreController.userList[index].rank,
                            index: index,
                            trailing: firestoreController.userList[index].point,
                            rank_color: Colors.grey[600]),
                      );
                    } else if (index == 2) {
                      return Card(
                        child: RankListTile(
                            title: firestoreController.userList[index].name,
                            sub_title: firestoreController.userList[index].rank,
                            index: index,
                            trailing: firestoreController.userList[index].point,
                            rank_color: Colors.brown[600]),
                      );
                    } else if (index > 2) {
                      return Card(
                        child: RankListTile(
                            title: firestoreController.userList[index].name,
                            sub_title: firestoreController.userList[index].rank,
                            index: index,
                            trailing: firestoreController.userList[index].point,
                            rank_color: null),
                      );
                    } else {
                      return Center(
                        child: Text('No Users'),
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
