import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';

import '../utills/CustomSnackbar.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  RxBool passwordVisibility = false.obs;

  Rx<String?> emailError = Rx<String?>(null);
  Rx<String?> passwordError = Rx<String?>(null);

  Future<void> login() async {
    if (validateForm()) {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      try {
        final response = await authService.login(
            emailController.text.trim(), passwordController.text.trim());
        Get.back();
        CustomSnackbar.showSuccess("Success", "Login Successful");
        Get.offNamed(BottomNavBarScreen.routeName);
      } catch (e) {
        Get.back();
        CustomSnackbar.showError("Error", e.toString());
      }
    }
  }

  Future<void> logout() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    await authService.logout();
    Get.offNamed(SplashScreen.routeName);
    Get.back();
  }

  bool validateForm() {
    final isemailValid = validateemail(emailController.text);
    final isPasswordValid = validatePassword(passwordController.text);
    return isemailValid && isPasswordValid;
  }

  bool validateemail(String email) {
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Invalid Email';
      return false;
    } else {
      emailError.value = '';
      return true;
    }
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

  bool get isAuthenticated => authService.isAuthenticated.value;
}
