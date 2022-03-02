import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/screens/sign_up/sign_up.dart';
import 'package:memes/presentation/widgets/text_with_textbutton.dart';
import 'package:sizer/sizer.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<AuthController>();
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 3.5.h),
          TextButton(
            child: Text('sign_in'.tr),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text.trim();
                String password = _passwordController.text;
                _auth.login(email, password);
              }
            },
          ),
          TextWithTextButton(
            text: 'no_account'.tr,
            textButtonText: 'sign_up'.tr,
            onPressed: () => Get.to(
              () => SignUp(),
            ),
          ),
        ],
      ),
    );
  }
}
