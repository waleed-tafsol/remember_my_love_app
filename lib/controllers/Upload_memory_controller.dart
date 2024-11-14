import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/models/categories.dart';
import 'package:remember_my_love_app/services/ApiServices.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';

import '../services/MemoryServices.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/Memory_scheduled_succeccfully.dart';

class UploadMemoryController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var pickedFiles = <File>[].obs;
  RxString sendTo = "Other".obs;
  RxBool buttonVisivility = true.obs;
  final recievingUsername = TextEditingController();
  final recievingUserPassword = TextEditingController();
  final recipientRelation = TextEditingController();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  RxList<Recipient> recipients = <Recipient>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<TimeOfDay> selectedTime = const TimeOfDay(hour: 0, minute: 0).obs;
  List<CatagoriesModel> categories = [];
  Rx<CatagoriesModel?> selectedCatagory = Rx<CatagoriesModel?>(null);

  @override
  void onInit() async {
    super.onInit();
    await FetchCategories();
    recipients.add(Recipient(
        emailController: TextEditingController(),
        contactController: TextEditingController()));
  }

  void check_null(var param) {
    return param != null ? param : Exception("null field found");
  }

  // Function to change the value of the DateTime variable
  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateSelectedTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  // void recievingUsername(TextEditingValue RecievingUsername) {
  //   recievingUsername.value = RecievingUsername;
  // }

  // void recievingUserPassword(TextEditingValue RecievingUserpassword) {
  //   recievingUserPassword.value = RecievingUserpassword;
  // }

  void reciepint_relation(TextEditingValue relation) {
    recipientRelation.value = relation;
  }

  void addRecipient() {
    recipients.add(Recipient(
        emailController: TextEditingController(),
        contactController: TextEditingController()));
  }

  void removeRecipient(int index) {
    if (recipients.length > 1) {
      recipients.removeAt(index);
    } else {
      Get.snackbar('Error', 'At least one recipient is required.');
    }
  }

  Future<void> pickImageOrVideo() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        pickedFiles.add(File(file.path)); // Add picked file to the list
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image or video: $e');
    }
  }

  Future<void> takePhotoOrVideo() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        pickedFiles.add(File(file.path)); // Add picked file to the list
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to take photo or video: $e');
    }
  }

  void removeFile(File file) {
    pickedFiles.remove(file); // Remove file from the list
    print("function ontap");
  }

  void removeAllFiles() {
    pickedFiles.clear(); // Remove file from the list
  }

  Future<void> createMemory() async {
    try {
      await Memoryservices.create_mem(
          title: titleController.value.text,
          description: descriptionController.value.text,
          category: selectedCatagory.value?.sId ?? "",
          deliveryDate: selectedDate,
          sendTo: sendTo,
          receivingUserName: recievingUsername.value.text,
          receivingUserPassword: recievingUserPassword.value.text,
          recipients: recipients,
          recipientsRelation: recipientRelation.value.text.trim(),
          files: pickedFiles);
      removeAllFiles();
      ColoredPrint.green("successful upload memory");

      Get.toNamed(MemoryScheduledSucceccfully.routeName);
    } catch (e) {
      Get.snackbar("ERROR", e.toString());
    }
  }

  Future<void> FetchCategories() async {
    try {
      ColoredPrint.red("fetch");
      Response? response =
          await ApiService.getRequest(ApiConstants.getcategories);
      final Map<String, dynamic> jsonMap = jsonDecode(response!.toString());

      //ColoredPrint.green(jsonMap['data']['categories'].toString());
      for (var element in jsonMap['data']['categories']) {
        categories.add(CatagoriesModel.fromJson(element));
      }
      //ColoredPrint.green(categories[1].toString());
    } on DioException catch (e) {
      if (e.response != null) {
        Get.snackbar("ERROR", e.toString());
      } else {
        Get.snackbar("ERROR", "Some thing Went wrong");
      }
    }
  }
}

class Recipient {
  TextEditingController emailController;
  TextEditingController contactController;

  Recipient({required this.emailController, required this.contactController});
}
