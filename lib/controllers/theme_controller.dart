import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/constants/theme_locale.constant.dart';
import 'package:memes/utils/helper/keys.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memes/utils/theme/theme.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  var isDark = false.obs;

  @override
  void onReady() {
    super.onReady();
    if (_loadTheme() == true) {
      isDark.value = true;
    } else {
      isDark.value = false;
    }
  }

  // Get the theme mode from local storage
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool _loadTheme() => _box.read(_key);

  void saveTheme(bool isDarkMode) => _box.writeIfNull(_key, isDarkMode);

  void changeTheme(ThemeData theme) {
    Get.changeTheme(theme);
    isDark.value = !isDark.value;
  }

  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}
