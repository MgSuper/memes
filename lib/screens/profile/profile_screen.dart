import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/utils/theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  final _theme = Get.find<ThemeController>();
  final _firestore = Get.find<FirestoreController>();
  final _auth = Get.find<AuthController>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemCount: _firestore.userList.length,
            itemBuilder: (context, index) {
              if (_firestore.userList[index].user_id == auth.currentUser!.uid) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (Get.isDarkMode) {
                                    // themeController.changeThemeMode(ThemeMode.light);
                                    _theme.changeTheme(Themes.lightTheme);
                                    _theme.saveTheme(false);
                                  } else {
                                    // themeController.changeThemeMode(ThemeMode.dark);
                                    _theme.changeTheme(Themes.darkTheme);
                                    _theme.saveTheme(true);
                                  }
                                },
                                icon: Icon(CupertinoIcons.moon_stars)),
                            IconButton(
                                onPressed: () => _auth.signOut(),
                                icon: Icon(Icons.logout)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        child: Text(
                          _firestore.userList[index].name[0],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Let\' begin',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      Text(
                        _firestore.userList[index].name,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('point'.tr,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02)),
                                Text(_firestore.userList[index].point
                                    .toString()),
                              ],
                            ),
                            Column(
                              children: [
                                Text('rank'.tr,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02)),
                                Text(_firestore.userList[index].rank),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
