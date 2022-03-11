import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class UserRanksScreen extends StatelessWidget {
  final _firestore = Get.find<FirestoreController>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 1.0.h, left: 2.0.w, right: 2.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'leader_board'.tr,
              style: TextStyle(
                fontSize: 4.0.w,
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
                        isMe: _firestore.userList[index].user_id == user!.uid
                            ? true
                            : false,
                      );
                    } else if (index == 1) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: Colors.grey[600],
                        radius: 18.0,
                        isMe: _firestore.userList[index].user_id == user!.uid
                            ? true
                            : false,
                      );
                    } else if (index == 2) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: Colors.brown[600],
                        radius: 20.0,
                        isMe: _firestore.userList[index].user_id == user!.uid
                            ? true
                            : false,
                      );
                    } else if (index > 2) {
                      return RankListTile(
                        title: _firestore.userList[index].name,
                        sub_title: _firestore.userList[index].rank,
                        index: index,
                        trailing: _firestore.userList[index].point.toString(),
                        rank_color: null,
                        radius: 22.0,
                        isMe: _firestore.userList[index].user_id == user!.uid
                            ? true
                            : false,
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
