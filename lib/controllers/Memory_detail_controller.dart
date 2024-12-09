import 'package:get/get.dart';
import 'package:remember_my_love_app/models/MemoryModel.dart';

class MemoryDetailController extends GetxController {
  final MemoryModel memory;

  var selectedImage = ''.obs;

  MemoryDetailController(this.memory);

  @override
  void onInit() {
    super.onInit();
    if (memory.files != null && memory.files!.isNotEmpty) {
      selectedImage.value = memory.files?[0] ?? '';
    }
  }

  void selectImage(String image) {
    selectedImage.value = image;
  }
}
