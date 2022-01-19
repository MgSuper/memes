import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';

class LanguageMenu extends GetView<LocaleController> {
  final localeController = Get.find<LocaleController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.language),
      offset: Offset(0, 30),
      itemBuilder: (context) =>
          localeController.optionsLocales.entries.map((item) {
        return PopupMenuItem(
          value: item.key,
          child: Text(item.value['description']),
        );
      }).toList(),
      onSelected: (String newValue) {
        print(newValue);
        localeController.updateLocale(newValue);
      },
    );
  }
}
