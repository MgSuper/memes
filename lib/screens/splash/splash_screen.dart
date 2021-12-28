import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () => Get.put(AuthController())
        // Get.offNamed('/home_screen')
        );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/let_laugh.png'),
              width: 125,
              height: 125,
            ),
          ),
        ],
      ),
    );
  }
}
