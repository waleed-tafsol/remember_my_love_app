import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Bottom_nav_bar_controller.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/controllers/MyMemoriesController.dart';
import 'package:remember_my_love_app/controllers/NotificationController.dart';
import 'package:remember_my_love_app/models/NotificationModel.dart';

import '../controllers/Calendar_controller.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/My_memories_screen.dart';

// import '../controllers/Calendar_controller.dart';

class BottomNavBarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<CalendarController>(() => CalendarController());
    Get.lazyPut<MyMemoryController>(() => MyMemoryController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    // Get.lazyPut<UploadMemoryController>(() => UploadMemoryController());
  }
}
