import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';

class UpdatePasswordController extends GetxController {
  @override
  void onInit() {
    // ColoredPrint.red("fallout");
    super.onInit();
  }

  RxBool isLoading = false.obs;

  TextEditingController currentpasswordController = TextEditingController();
  RxBool currentpasswordVisibility = false.obs;
  TextEditingController newpasswordController = TextEditingController();
  RxBool newpasswordVisibility = false.obs;
  TextEditingController confirmpasswordController = TextEditingController();
  RxBool confirmpasswordVisibility = false.obs;

  Future<void> updatePassword() async {
    isLoading.value = true;
    Response? response =
        await ApiService.patchRequest(ApiConstants.updatePassword, {
      "password": newpasswordController.value.text,
      "passwordConfirm": confirmpasswordController.value.text,
      "currentPassword": currentpasswordController.value.text
    });
    if (response != null) {
      CustomSnackbar.showSuccess(
          "Error", "Password Changed Successfully Please Login Again");
      await authService.logout();
    }

    isLoading.value = false;
  }
}
