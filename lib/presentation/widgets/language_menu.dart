import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';

class LanguageMenu extends GetView<LocaleController> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.language),
      offset: const Offset(0, 35),
      itemBuilder: (context) => controller.optionsLocales.entries.map((item) {
        return PopupMenuItem(
          value: item.key,
          child: Text(
            item.value['description'],
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onSelected: (String newValue) {
        controller.updateLocale(newValue);
      },
    );
  }
}
