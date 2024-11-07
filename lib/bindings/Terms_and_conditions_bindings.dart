import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Terms_and_condition_controller.dart';

class TermsAndConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsAndConditionController>(
        () => TermsAndConditionController());
  }
}
