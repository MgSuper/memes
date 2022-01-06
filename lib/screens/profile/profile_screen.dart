import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/widgets/hero_title.dart';
import 'package:memes/widgets/rounded_elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeroTitle(
              title:
                  '${AuthController.authInstance.firebaseUser.value?.displayName}!',
              subtitle: 'Let\'s begin...'),
          Expanded(flex: 8, child: Container()),
          RoundedElevatedButton(
            title: 'Sign out',
            onPressed: () => AuthController.authInstance.signOut(),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
          ),
        ],
      ),
    );
  }
}
