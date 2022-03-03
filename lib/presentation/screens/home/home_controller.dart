import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends GetxController {
  final timer = 3.obs;

  void runTimer() {
    Future.delayed(Duration(seconds: 1), () {
      timer.value--;
      if (timer >= 0) {
        runTimer();
      } else {
        if (Get.isDialogOpen ?? false) Get.back();
        timer.value = 3;
      }
    });
  }
}
