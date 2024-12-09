import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/EditProfileController.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}
