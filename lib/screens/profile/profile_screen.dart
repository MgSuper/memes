import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController firestoreController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AuthController.authInstance.signOut();
              },
              child: Text('Logout'),
            ),
            TextButton(
                onPressed: () {
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                },
                child: Icon(Icons.change_circle))
          ],
        ),
      ),
    );
  }
}
