import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Choose_your_plan_controller.dart';

class ChooseYourPlanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseYourPlanController>(() => ChooseYourPlanController());
  }
}
