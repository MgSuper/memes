import 'package:flutter/material.dart';
import 'package:memes/constants/style.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:memes/presentation/screens/sign_in/localWidgets/sign_in_buttons.dart';
import 'package:sizer/sizer.dart';

class SignInForm extends StatefulWidget {
  SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _locale = Get.find<LocaleController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildTextFormFields(),
            SignInButtons(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    return Column(
      children: [
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
        SizedBox(height: 1.0.h),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'password'.tr,
            hintStyle:
                _locale.getLocale() == 'MM' ? kMyanmarFont : kEnglishFont,
          ),
          obscureText: true,
          validator: (value) {
            if (value.toString().length < 6) {
              return 'password_message'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}
