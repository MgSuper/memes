import 'package:flutter/material.dart';
import 'package:memes/widgets/widgets.dart';
import 'localWidgets/sign_in_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: Column(
            children: [
              // shows header title
              HeroTitle(
                title: 'Welcome!',
                subtitle: 'Enter email and password to login...',
              ),
              // shows image
              HeroImage(
                path: 'assets/loginHero.svg',
                sementicLabel: 'Login Hero',
              ),
              // shows textfields and buttons
              SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}
