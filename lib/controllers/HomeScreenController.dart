import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remember_my_love_app/models/memoryModel.dart';

import 'package:remember_my_love_app/utills/Colored_print.dart';

import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() async {
    await getmemories();
    super.onInit();
  }

  RxList<MemoryModel> memories = <MemoryModel>[].obs;
  RxBool isloading = false.obs;

  Future<void> getmemories() async {
    isloading.value = true;
    ColoredPrint.green("Fetching Memories");
    Response? response = await ApiService.getRequest(
      ApiConstants.getAllMemories,
    );
    if (response != null) {
      List<Map<String, dynamic>> memoryList =
          List<Map<String, dynamic>>.from(response.data["memories"]);
      memories.clear();
      memories.addAll(memoryList
          .map((memoryData) => MemoryModel.fromJson(memoryData))
          .toList());
    }
    isloading.value = false;
  }
}
