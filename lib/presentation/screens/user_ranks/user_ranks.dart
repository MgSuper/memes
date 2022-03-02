import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/widgets/widgets.dart';

class UserRanksScreen extends StatelessWidget {
  final _firestore = Get.find<FirestoreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                () => ListView.separated(
                  itemCount: _firestore.userList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: Colors.amber[600],
                        radius: 16.0,
                      );
                    } else if (index == 1) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: Colors.grey[600],
                        radius: 18.0,
                      );
                    } else if (index == 2) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: Colors.brown[600],
                        radius: 20.0,
                      );
                    } else if (index > 2) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: null,
                        radius: 22.0,
                      );
                    } else {
                      return Center(
                        child: Text('No Record'),
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
