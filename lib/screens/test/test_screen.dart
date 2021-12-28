import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memes/controllers/test_controller.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TestController c = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('I\'m ${c.count}')),
      ),
    );
  }
}
