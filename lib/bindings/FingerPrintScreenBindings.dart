import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/FingerPrintScreenController.dart';

class FingerPrintScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingerPrintScreenController>(
        () => FingerPrintScreenController());
  }
}
