import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Questions_screen.dart';

import '../utills/CustomSnackbar.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passCnfirmController = TextEditingController();
  TextEditingController signupPassController = TextEditingController();
  TextEditingController signupemailController = TextEditingController();

  RxBool passwordVisibility = false.obs;
  RxBool confirmPasswordVisibility = false.obs;

  Rx<String?> emailError = Rx<String?>(null);
  Rx<String?> passwordError = Rx<String?>(null);
  Rx<String?> nameError = Rx<String?>(null);
  Rx<String?> userNameError = Rx<String?>(null);
  Rx<String?> passconfrmErr = Rx<String?>(null);

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

  Future<void> loginFingerPrint() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    if (await authService.loginWithFingerPrint() ?? false) {
      Get.back();
      CustomSnackbar.showSuccess("Success", "Logged In Successfully");
      Get.toNamed(BottomNavBarScreen.routeName);
    } else {
      Get.back();
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      if (await authService.loginWithGoogle() ?? false) {
        Get.back();
        CustomSnackbar.showSuccess("Success", "Logged In Successfully");
        Get.toNamed(BottomNavBarScreen.routeName);
      } else {
        Get.back();
        CustomSnackbar.showSuccess("error", "Google SignIn Faild");
        Get.toNamed(BottomNavBarScreen.routeName);
      }
    } catch (e) {
      Get.back();
    }
  }

  Future<void> signup() async {
    /* if (signupValidateForm()) {
      ColoredPrint.blue("entered");
      Get.dialog(const Center(child: CircularProgressIndicator()));
      try {
        final response = await authService.Signup(
            /* nameController.text.trim(),
            signupemailController.text.trim(),
            signupPassController.text.trim(),
            passCnfirmController.text.trim() */
            "abc",
            "123@gmail.com",
            "12345678",
            "12345678");
        Get.back();
        CustomSnackbar.showSuccess("Success", "Signup Successful");
        Get.offNamed(BottomNavBarScreen.routeName);
      } catch (e) {
        Get.back();
        CustomSnackbar.showError("Error", e.toString());
      }
    } */
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    try {
      final response = await authService.Signup(
          nameController.text.trim(),
          userNameController.text.trim(),
          signupemailController.text.trim(),
          signupPassController.text.trim(),
          passCnfirmController.text.trim()
          // "12345678", //hardcoded password
          // "12345678"
          ); //confirmed password
      if (response != null) {
        Get.back();
        CustomSnackbar.showSuccess("Success", "Signup Successful");
        Get.offNamed(QuestionsScreen.routeName);
      }
      Get.back();
    } catch (e) {
      Get.back();
      CustomSnackbar.showError("Error", e.toString());
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

  bool signupValidateForm() {
    final isemailValid = validateemail(signupemailController.text);
    final isPasswordValid = validatePassword(signupPassController.text);
    final isNameValid = validateName(nameController.text);
    final isUserNameValid = validateUserName(userNameController.text);
    final isPassConfirm = revalidatePassword(passCnfirmController.text);
    return isemailValid &&
        isPasswordValid &&
        isNameValid &&
        isPassConfirm &&
        isUserNameValid;
  }

  bool validateName(String Name) {
    if (Name.isEmpty) {
      nameError.value = 'Name is required';
      return false;
    } else {
      nameError.value = '';
      return true;
    }
  }

  bool validateUserName(String Name) {
    if (Name.isEmpty) {
      userNameError.value = 'Name is required';
      return false;
    } else {
      userNameError.value = '';
      return true;
    }
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

  bool revalidatePassword(String password) {
    /* if (!validatePassword(password)) {
      passconfrmErr.value = passwordError.value;
      return false;
    } else {
      if (passwordController.text.trim() == passCnfirmController.text.trim()) {
        passconfrmErr.value = "";
        return true;
      }
      ColoredPrint.green(
          "pass: ${passwordController.text} , cnfrmpass: ${passCnfirmController.text}");
      passconfrmErr.value = "password didn't match";
      return false;
    } */
    if (passwordController.text.trim() == passCnfirmController.text.trim()) {
      ColoredPrint.green(
          "pass: ${passwordController.text} , cnfrmpass: ${passCnfirmController.text}");
      passconfrmErr.value = "";
      return true;
    }
    passconfrmErr.value = "password didn't matched";
    return false;
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
// 