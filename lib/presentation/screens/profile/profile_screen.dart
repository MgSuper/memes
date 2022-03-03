import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  final _locale = Get.find<LocaleController>();
  final _firestore = Get.find<FirestoreController>();
  final _auth = Get.find<AuthController>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        elevation: 0,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _firestore.userList.length,
          itemBuilder: (_, index) {
            if (_firestore.userList[index].user_id == auth.currentUser!.uid) {
              return ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/profiles/${_firestore.userList[index].rank}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          _firestore.userList[index].name,
                          style: TextStyle(fontSize: 6.0.w),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'point'.tr,
                              ),
                              Text(_firestore.userList[index].point.toString()),
                            ],
                          ),
                        ),
                        _locale.getLocale() == 'MM'
                            ? SizedBox(
                                height: 0.0,
                              )
                            : SizedBox(
                                height: 14.0,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'rank'.tr,
                              ),
                              Text(_firestore.userList[index].rank),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'language'.tr,
                            ),
                            LanguageMenu(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
