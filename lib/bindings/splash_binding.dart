import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/OtpController.dart';
import 'package:remember_my_love_app/controllers/Update_Pass_controller.dart';
import 'package:remember_my_love_app/controllers/forgotPass_controller.dart';
import '../controllers/AuthController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ForgotpassController>(() => ForgotpassController());
    Get.lazyPut<Otpcontroller>(() => Otpcontroller());
  }
}
