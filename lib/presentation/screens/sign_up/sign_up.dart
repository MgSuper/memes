import 'package:flutter/material.dart';
import 'package:memes/constants/style.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/widgets/widgets.dart';
import 'package:memes/utils/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'localWidgets/sign_up_buttons.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final LocaleController _locale = Get.find();
  final ThemeController _theme = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            icon: Obx(
              () => _theme.isDark == true
                  ? const Icon(Icons.dark_mode_outlined)
                  : const Icon(Icons.light_mode_outlined),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.h),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Image(
                  image: AssetImage('assets/images/show_signup_to_user.png'),
                ),
              ),
              buildTextFormFields(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildTextFormFields() {
    return Expanded(
      flex: 8,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'name'.tr,
              hintStyle:
                  _locale.getLocale() == 'MM' ? kMyanmarFont : kEnglishFont,
            ),
            validator: (value) {
              if (value.toString().length <= 2) {
                return 'name_message'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'email'.tr,
              hintStyle:
                  _locale.getLocale() == 'MM' ? kMyanmarFont : kEnglishFont,
            ),
            validator: (value) {
              bool _isEmailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (!_isEmailValid) {
                return 'email_message'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password'.tr,
              hintStyle:
                  _locale.getLocale() == 'MM' ? kMyanmarFont : kEnglishFont,
            ),
            validator: (value) {
              if (value.toString().length < 6) {
                return 'password_message'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          SignUpButtons(
            formKey: _formKey,
            nameController: _nameController,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ],
      ),
    );
  }
}
