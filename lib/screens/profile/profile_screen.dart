import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/controllers/theme_controller.dart';
import 'package:memes/theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                          themeController.changeTheme(Themes.lightTheme);
                          themeController.saveTheme(false);
                        } else {
                          // themeController.changeThemeMode(ThemeMode.dark);
                          themeController.changeTheme(Themes.darkTheme);
                          themeController.saveTheme(true);
                        }
                      },
                      icon: Icon(CupertinoIcons.moon_stars)),
                  IconButton(
                      onPressed: () => AuthController.authInstance.signOut(),
                      icon: Icon(Icons.logout)),
                ],
              ),
            ),
            Image(
              image: AssetImage('assets/images/let_laugh.png'),
              width: 150.0,
              height: 150.0,
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
              '${AuthController.authInstance.firebaseUser.value?.displayName}',
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
                      Text('Points',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      Text('0'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Rank',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)),
                      Text('Newbie'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
