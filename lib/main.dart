import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllerBindings.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/screens/splash/splash_screen.dart';
import 'package:memes/utils/locale/locale_string.dart';
import 'package:memes/utils/theme/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
  await GetStorage.init();
  await firebaseInitialization.then((value) async {
    Get.put(AuthController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocaleController _locale = Get.put(LocaleController());
  final ThemeController _theme = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      translations: LocaleString(),
      locale: _locale.getLocale() == 'MM'
          ? Locale('my', 'MM')
          : Locale('en', 'US'), // Not Get.deviceLocale
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      themeMode: _theme.theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: SplashScreen(),
    );
  }
}
