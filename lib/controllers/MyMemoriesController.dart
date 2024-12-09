import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../constants/ApiConstant.dart';
import '../models/MemoryModel.dart';
import '../services/ApiServices.dart';

class MyMemoryController extends GetxController {
  final MemoryModel memory;

  var selectedImage = ''.obs;

  MyMemoryController(this.memory);

  @override
  void onInit() {
    super.onInit();
    if (memory.files != null && memory.files!.isNotEmpty) {
      selectedImage.value = memory.files?.first ?? '';
    }
  }

  Future<void> fetchMemories() async {
    Response? response = await ApiService.getRequest(
      ApiConstants.getAllMemories,
    );
  }
}
