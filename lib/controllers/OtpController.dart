import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/forgotPass_controller.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/ResetPass_screen.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';

import '../view/screens/auth_screens/OTP_screen.dart';
import 'AuthController.dart';

class Otpcontroller extends GetxController {
  final otpController = ''.obs;
  var remainingSeconds = 120.obs;
  var canResendOtp = false.obs;
  //RxBool passwordVisibility = false.obs;
  //RxBool confirmpasswordVisibility = false.obs;
  Timer? _timer;
  Rx<String?> passwordError = Rx<String?>(null);
  TextEditingController newpassController = TextEditingController();
  TextEditingController newpasscnfrmController = TextEditingController();
  TextEditingController newresetpassController = TextEditingController();
  TextEditingController newresetpasscnfrmController = TextEditingController();
  ForgotpassController forgotPassController = Get.find();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    remainingSeconds.value = 120;
    canResendOtp.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResendOtp.value = true;
        _timer?.cancel();
      }
    });
  }

  void resendOtp() {
    if (canResendOtp.value) {
      forgot_pass();
      Get.snackbar("OTP Resent", "A new OTP has been sent to your email!");
    }
  }

  TextEditingController forgotemailController = TextEditingController();
  //TextEditingController newPassController = TextEditingController();
  TextEditingController newPassConfirmController = TextEditingController();

  Future<void> forgot_pass() async {
    if (AuthController().validateemail(forgotemailController.text)) {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      try {
        final response =
            await authService.forgotPassword(forgotemailController.text.trim());
        ColoredPrint.red("$response");
        Get.back();

        CustomSnackbar.showSuccess("Success", "Email sent");
        Get.toNamed(OtpScreen.routeName);
      } catch (e) {
        Get.back();
        CustomSnackbar.showError("Error", e.toString());
      }
    }
  }

  Future<void> verifyOtp() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    try {
      final response = await authService.verifyOnetime(
          forgotemailController.text.trim(),
          int.parse(newpassController.text.trim()));
      Get.back();
      CustomSnackbar.showSuccess("Success", "Otp Verified");
      Get.toNamed(ResetpassScreen.routeName);
    } catch (e) {
      Get.back();
      CustomSnackbar.showError("Error", e.toString());
    }
  }

  Future<void> resetPass() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    try {
      final response = await authService.resetPass(
          forgotemailController.text.trim(),
          int.parse(newpassController.text.trim()),
          newresetpassController.text.trim(),
          newpasscnfrmController.text.trim());
      Get.back();
      CustomSnackbar.showSuccess("Success", "Password reset successfull");
      Get.offAllNamed(SplashScreen.routeName);
    } catch (e) {
      Get.back();
      CustomSnackbar.showError("Error", e.toString());
    }
  }

  String formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    } else if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      return false;
    } else {
      passwordError.value = '';
      return true;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
