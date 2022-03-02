import 'dart:ui';

import 'package:get/get.dart';
import 'package:memes/constants/theme_locale.constant.dart';
import 'package:memes/utils/helper/keys.dart';

class LocaleController extends GetxController {
  final RxString locale = Get.locale.toString().obs;

  final Map<String, dynamic> optionsLocales = {
    'en_US': {
      'languageCode': 'en',
      'countryCode': 'US',
      'description': 'English'
    },
    'my_MM': {
      'languageCode': 'my',
      'countryCode': 'MM',
      'description': 'Myanmar'
    },
  };

  String getLocale() => box.read(localeKey) ?? '';

  void updateLocale(String key) {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();
    // Update storage
    box.write(localeKey, countryCode);
  }
}
