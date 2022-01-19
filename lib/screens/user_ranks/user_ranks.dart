import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/widgets/widgets.dart';

class UserRanksScreen extends StatelessWidget {
  final _firestore = Get.find<FirestoreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'leader_board'.tr,
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
                  itemCount: _firestore.userList.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Card(
                        child: RankListTile(
                            title: _firestore.userList[index].name,
                            sub_title: _firestore.userList[index].rank,
                            index: index,
                            trailing:
                                _firestore.userList[index].point.toString(),
                            rank_color: Colors.amber[600]),
                      );
                    } else if (index == 1) {
                      return Card(
                        child: RankListTile(
                            title: _firestore.userList[index].name,
                            sub_title: _firestore.userList[index].rank,
                            index: index,
                            trailing:
                                _firestore.userList[index].point.toString(),
                            rank_color: Colors.grey[600]),
                      );
                    } else if (index == 2) {
                      return Card(
                        child: RankListTile(
                            title: _firestore.userList[index].name,
                            sub_title: _firestore.userList[index].rank,
                            index: index,
                            trailing:
                                _firestore.userList[index].point.toString(),
                            rank_color: Colors.brown[600]),
                      );
                    } else if (index > 2) {
                      return Card(
                        child: RankListTile(
                            title: _firestore.userList[index].name,
                            sub_title: _firestore.userList[index].rank,
                            index: index,
                            trailing:
                                _firestore.userList[index].point.toString(),
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
