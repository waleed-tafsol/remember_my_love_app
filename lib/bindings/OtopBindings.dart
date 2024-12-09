import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/OtpController.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Otpcontroller>(() => Otpcontroller());
  }
}
