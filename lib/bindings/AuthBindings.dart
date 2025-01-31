import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';

import '../controllers/Questions_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<QuestionsController>(() => QuestionsController());
  }
}
