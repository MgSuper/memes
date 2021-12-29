import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknow Page'),
      ),
      body: Center(
        child: Text(
          'No Page Found',
          style: Get.textTheme.headline5,
        ),
      ),
    );
  }
}
