import 'package:get/get.dart';
import '../controllers/Choose_your_plan_controller.dart';

class ChooseYourPlanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseYourPlanController>(() => ChooseYourPlanController());
  }
}
