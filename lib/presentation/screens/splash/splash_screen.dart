import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
