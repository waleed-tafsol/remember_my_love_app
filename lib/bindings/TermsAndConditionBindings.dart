import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/TermsAndConditionsController.dart';

class TermsAndConditionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsAndConditionsController>(() => TermsAndConditionsController());
  }
}
