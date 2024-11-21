import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/UpdateUserController.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Update_user_details.dart';

class UpdateUserscreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserController>(() => UpdateUserController());
  }
}
