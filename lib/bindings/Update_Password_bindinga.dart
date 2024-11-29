import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/UpdatePasswordController.dart';

class UpdatePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(() => UpdatePasswordController());
  }
}
