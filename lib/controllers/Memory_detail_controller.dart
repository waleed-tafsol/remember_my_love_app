import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/controllers/MyMemoriesController.dart';
import 'package:remember_my_love_app/models/MemoryModel.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';

import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';

class MemoryDetailController extends GetxController {
  final MemoryModel memory;

  var selectedImage = ''.obs;

  RxBool isloading = false.obs;

  MemoryDetailController(this.memory);

  @override
  void onInit() {
    super.onInit();
    if (memory.files != null && memory.files!.isNotEmpty) {
      selectedImage.value = memory.files?[0] ?? '';
    }
  }

  Future<void> deleteMemory() async {
    try {
      isloading.value = true;
      final Response? response = await ApiService.deleteRequest(
          ApiConstants.deleteMemory + memory.sId!);

      if (response != null) {
        HomeScreenController homeController = Get.find();
        MyMemoryController myMemoriesController = Get.find();
        myMemoriesController.by_me_images
            .removeWhere((e) => memory.files![0] == e);
        myMemoriesController.for_me_images
            .removeWhere((e) => memory.files![0] == e);

        homeController.memories.removeWhere((e) => memory.sId == e.sId);

        homeController.callMemoriesDates();
        isloading.value = false;
        Get.back();
      }
      isloading.value = false;
    } catch (e) {
      isloading.value = false;
      CustomSnackbar.showError('Error', e.toString());
    }
  }
}
