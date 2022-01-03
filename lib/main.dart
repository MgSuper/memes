import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controller/auth_controller.dart';
import 'package:memes/controllerBindings.dart';
import 'package:memes/screens/splash/splash_screen.dart';

void main() async {
  // Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) async {
    Get.put(AuthController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // bind our app with the  Getx Controller
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.amaranthTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
