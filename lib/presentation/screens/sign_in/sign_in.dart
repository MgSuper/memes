import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/controllers/theme_controller.dart';
import 'package:memes/presentation/widgets/widgets.dart';
import 'package:memes/utils/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'localWidgets/sign_in_form.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final _theme = Get.find<ThemeController>();
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          LanguageMenu(),
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
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: const Image(
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
