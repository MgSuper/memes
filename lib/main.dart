import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/controllerBindings.dart';
import 'package:memes/controllers/theme_controller.dart';
import 'package:memes/screens/splash/splash_screen.dart';
import 'package:memes/theme/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  // Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  await firebaseInitialization.then((value) async {
    Get.put(AuthController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // bind our app with the Getx Controller
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: themeController.theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: SplashScreen(),
    );
  }
}
