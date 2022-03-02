import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllerBindings.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/screens/splash/splash_screen.dart';
import 'package:memes/utils/locale/locale_string.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memes/utils/theme/theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  await firebaseInitialization.then((value) async {
    Get.put(AuthController());
    Get.put(LocaleController());
    Get.put(ThemeController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocaleController _locale = Get.find();
  final ThemeController _theme = Get.find();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          initialBinding: ControllerBindings(),
          translations: LocaleString(),
          locale: _locale.getLocale() == 'MM'
              ? const Locale('my', 'MM')
              : const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          themeMode: _theme.theme,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
