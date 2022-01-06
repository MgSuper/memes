import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/screens/sign_up/sign_up.dart';
import 'package:memes/widgets/rounded_elevated_button.dart';
import 'package:memes/widgets/text_with_textbutton.dart';

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
    // final _authController = Get.find<AuthController>();

    return Expanded(
      flex: 1,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          RoundedElevatedButton(
            title: 'Sign in',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text.trim();
                String password = _passwordController.text;

                AuthController.authInstance.login(email, password);
              }
            },
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.4,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          TextWithTextButton(
            text: 'Don\'t have an account?',
            textButtonText: 'Sign up',
            onPressed: () => Get.to(() => SignUp()),
          ),
        ],
      ),
    );
  }
}