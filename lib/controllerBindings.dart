import 'package:get/get.dart';
import 'package:memes/controllers/auth_controller.dart';
import 'package:memes/controllers/chip_controller.dart';
import 'package:memes/controllers/firestore_controller.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar_controller.dart';
import 'package:memes/screens/collection/collection_controller.dart';
import 'package:memes/screens/home/home_controller.dart';
import 'package:memes/screens/profile/profile_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<BottomTabBarController>(() => BottomTabBarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<CollectionController>(() => CollectionController());
    Get.lazyPut<ChipController>(() => ChipController());
    Get.lazyPut<FirestoreController>(() => FirestoreController());
  }
}
