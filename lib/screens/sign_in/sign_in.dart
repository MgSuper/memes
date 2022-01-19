import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/utils/theme/theme.dart';
import 'package:memes/widgets/widgets.dart';
import 'localWidgets/sign_in_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _theme = Get.find<ThemeController>();
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(.1),
        actions: [
          LanguageMenu(),
          IconButton(
            onPressed: () {
              print(Get.isDarkMode);
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
            icon: _box.read('isDarkMode') == true
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Image(
                  image: AssetImage('assets/images/show_login_to_user.png'),
                ),
              ),
            ),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}
