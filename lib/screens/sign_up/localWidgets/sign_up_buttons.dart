import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/screens/sign_in/sign_in.dart';
import 'package:memes/widgets/widgets.dart';

class SignUpButtons extends StatelessWidget {
  const SignUpButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _nameController = nameController,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<AuthController>();

    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String name = _nameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text;
                _auth.register(name, email, password);
              }
            },
            child: Text('sign_up'.tr),
          ),
          TextWithTextButton(
            text: 'already_have_account'.tr,
            textButtonText: 'sign_in'.tr,
            onPressed: () => Get.offAll(() => SignIn()),
          ),
        ],
      ),
    );
  }
}
