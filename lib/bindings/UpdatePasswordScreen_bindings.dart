import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Update_Pass_controller.dart';

class UpdatepasswordscreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePassController>(() => UpdatePassController());
  }
}
