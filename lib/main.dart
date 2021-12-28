import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInitialization.then((value) async {
    await Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/images/let_laugh.png'),
                width: 125,
                height: 125,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
