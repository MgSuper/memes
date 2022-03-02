import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/utils/helper/keys.dart';

class LocaleController extends GetxController {
  final RxString locale = Get.locale.toString().obs;
  var _box = GetStorage();

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

  String getLocale() => _box.read(localeKey) ?? '';

  void updateLocale(String key) {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();
    // Update storage
    _box.write(localeKey, countryCode);
  }
}
