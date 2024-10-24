import 'package:get/get.dart';

import '../constants/assets.dart';

class MemoryDetailController extends GetxController {
  final List<String> images = [
    Image_assets.userImage,
    Image_assets.animation_cloud_back,
    Image_assets.animation_cloud_front,
    Image_assets.scaffold_image,
  ];

  var selectedImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedImage.value = images[0];
  }

  void selectImage(String image) {
    selectedImage.value = image;
  }
}
