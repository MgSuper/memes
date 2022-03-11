import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'localWidgets/sign_in_form.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          LanguageMenu(),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0.w),
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
