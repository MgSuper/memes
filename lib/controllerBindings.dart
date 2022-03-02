import 'package:get/get.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/presentation/screens/home/home_controller.dart';
import 'package:memes/presentation/screens/profile/profile_controller.dart';
import 'package:memes/presentation/screens/user_ranks/user_ranks_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<BottomTabBarController>(BottomTabBarController());
    Get.put<HomeController>(HomeController());
    Get.put<ProfileController>(ProfileController());
    Get.put<UserRanksController>(UserRanksController());
    Get.put<ChipController>(ChipController());
    Get.put<FirestoreController>(FirestoreController());
    Get.put<AdController>(AdController());
  }
}
