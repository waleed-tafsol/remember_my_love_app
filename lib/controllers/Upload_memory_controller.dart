import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadMemoryController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var pickedFiles = <File>[].obs; // Observable list of picked files

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
}
