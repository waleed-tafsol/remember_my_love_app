import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadMemoryController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var pickedFiles = <File>[].obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  RxList<Recipient> recipients = <Recipient>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay(hour: 0, minute: 0).obs;

  @override
  void onInit() {
    super.onInit();
    recipients.add(Recipient(
        emailController: TextEditingController(),
        contactController: TextEditingController()));
  }

  // Function to change the value of the DateTime variable
  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateSelectedTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
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
}

class Recipient {
  TextEditingController emailController;
  TextEditingController contactController;

  Recipient({required this.emailController, required this.contactController});
}
