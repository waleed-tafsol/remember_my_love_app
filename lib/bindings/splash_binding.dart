import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/OtpController.dart';
import '../controllers/AuthController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<Otpcontroller>(() => Otpcontroller());
  }
}
