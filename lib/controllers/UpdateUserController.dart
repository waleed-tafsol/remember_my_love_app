import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';

class UpdateUserController extends GetxController {
  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();
  TextEditingController contact = TextEditingController();
  String? imageUploadData;
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> pickedFiles = Rx<XFile?>(null);

  Rx<String?> nameError = Rx<String?>(null);
  Rx<String?> emailError = Rx<String?>(null);
  Rx<String?> usernameError = Rx<String?>(null);
  Rx<String?> contactError = Rx<String?>(null);

  bool validateName(String Name) {
    if (Name.isEmpty) {
      nameError.value = 'Name is required';
      return false;
    } else {
      nameError.value = '';
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

  bool validateUserName(String Name) {
    if (Name.isEmpty) {
      usernameError.value = 'Name is required';
      return false;
    } else {
      usernameError.value = '';
      return true;
    }
  }

  Future<void> takePhotoOrVideo() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        pickedFiles.value = file;
        // uploadMedia();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to take photo or video: $e');
    }
  }

  Future<void> Update_user() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    try {
      final response = await ApiService.patchRequest(ApiConstants.updateUser, {
        "name": name_controller.value,
        "email": email_controller.value,
        "username": username_controller.value,
        "contact": contact.value,
        "photo": imageUploadData.toString()
      });

      Get.back();
      CustomSnackbar.showSuccess("Success", "User Updated Successfully");
      Get.offNamed(BottomNavBarScreen.routeName);
    } catch (e) {
      Get.back();
      CustomSnackbar.showError("Error", e.toString());
    }
  }

  Future<void> uploadMedia() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

    // ColoredPrint.red("Uploading images to cloud");
    // ColoredPrint.magenta(pickedFiles[0].path);
    ColoredPrint.magenta(pickedFiles.value!.name);

    FormData formData = FormData.fromMap({
      'images': await MultipartFile.fromFile(
        pickedFiles.value!.path,
        filename: pickedFiles.value!.name,
      ),
    });

    Response? response = await ApiService.postRequest(
      ApiConstants.uploadPictures,
      formData,
    );
    ColoredPrint.green(response.toString());
    if (response?.statusCode == 201 && response != null) {
      //ColoredPrint.green("status good");
      imageUploadData = response.data["fileDetails"][0]["key"];
      ColoredPrint.green(imageUploadData!);
      Get.back();
      //Get.toNamed(WriteAMemoryScreen.routeName);
    }
  }

  Future<void> pickImageOrVideo() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        pickedFiles.value = file; // Add picked file to the list
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image or video: $e');
    }
  }
}
