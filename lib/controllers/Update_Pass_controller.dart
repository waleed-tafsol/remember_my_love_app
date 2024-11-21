import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';

class UpdatePassController extends GetxController {
  TextEditingController current_pass_controller = TextEditingController();
  TextEditingController new_pass_controller = TextEditingController();
  TextEditingController confirm_pass_controller = TextEditingController();

  RxBool curr_passwordVisibility = false.obs;
  RxBool new_passwordVisibility = false.obs;
  RxBool confirm_passwordVisibility = false.obs;

  Rx<String?> newpasswordError = Rx<String?>(null);
  Rx<String?> curr_passwordError = Rx<String?>(null);
  Rx<String?> cnfrm_passwordError = Rx<String?>(null);

  Future<void> ChangePass() async {
    if (validateForm()) {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      try {
        final response = await authService.ChangePass(
            current_pass_controller.text.trim(),
            new_pass_controller.text.trim(),
            confirm_pass_controller.text.trim());
        //Get.back();
        ColoredPrint.red("successful");
        CustomSnackbar.showSuccess("Success", "Password Changed successfully");
        //Get.offAllNamed(SplashScreen.routeName);
      } catch (e) {
        // Get.back();
        CustomSnackbar.showError("Success", "Password Changed successfully");
      }
    }
  }

  bool validateForm() {
    final isCurrPasswordValid =
        validatePassword(current_pass_controller.text, curr_passwordError);
    final isNewPasswordValid =
        validatePassword(new_pass_controller.text, newpasswordError);
    final isConfirmmPasswordValid =
        validatePassword(confirm_pass_controller.text, cnfrm_passwordError);
    return isCurrPasswordValid && isNewPasswordValid && isConfirmmPasswordValid;
  }

  bool validatePassword(String password, Rx<String?> Err_var) {
    if (password.isEmpty) {
      Err_var.value = 'Password is required';
      return false;
    } else if (password.length < 8) {
      Err_var.value = 'Password must be at least 8 characters';
      return false;
    } else {
      Err_var.value = '';
      return true;
    }
  }
}
