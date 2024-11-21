import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Bottom_nav_bar_controller.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/controllers/Update_Pass_controller.dart';

class BottomNavBarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    // Get.lazyPut<UploadMemoryController>(() => UploadMemoryController());
  }
}
