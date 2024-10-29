import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Bottom_nav_bar_controller.dart';

class BottomNavBarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    // Get.lazyPut<UploadMemoryController>(() => UploadMemoryController());
  }
}
