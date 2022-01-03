import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';
import 'package:memes/controller/auth_controller.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar.dart';
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
  }
}
