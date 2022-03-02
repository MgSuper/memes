import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/constants/style.dart';
import 'package:memes/constants/theme_locale.constant.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/controllers/theme_controller.dart';
import 'package:memes/utils/theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeController _theme = Get.find();
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
                              'Language',
                            ),
                            PopupMenuButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.language),
                              offset: Offset(0, 35),
                              itemBuilder: (context) =>
                                  _locale.optionsLocales.entries.map((item) {
                                return PopupMenuItem(
                                  value: item.key,
                                  child: Text(item.value['description']),
                                );
                              }).toList(),
                              onSelected: (String newValue) {
                                print('new value ${newValue}');
                                _locale.updateLocale(newValue);
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Theme',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                            IconButton(
                              onPressed: () {
                                if (Get.isDarkMode) {
                                  _theme.changeTheme(Themes.lightTheme);
                                  _theme.saveTheme(false);
                                } else {
                                  _theme.changeTheme(Themes.darkTheme);
                                  _theme.saveTheme(true);
                                }
                              },
                              icon: Obx(
                                () => _theme.isDark == true
                                    ? const Icon(Icons.dark_mode_outlined)
                                    : const Icon(Icons.light_mode_outlined),
                              ),
                            ),
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
