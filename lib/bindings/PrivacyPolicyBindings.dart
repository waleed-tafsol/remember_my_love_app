import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/PrivacyPolicyController.dart';

class PrivacyPolicyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
  }
}
