import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
