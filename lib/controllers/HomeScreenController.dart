import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remember_my_love_app/controllers/Calendar_controller.dart';
import 'package:remember_my_love_app/models/UserModel.dart';
import 'package:remember_my_love_app/models/memories_dates_model.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import '../constants/ApiConstant.dart';
import '../models/MemoryModel.dart';
import '../services/ApiServices.dart';
import 'MyMemoriesController.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() async {
    calendarController = Get.find();
    isloading.value = true;
    await callMemoriesDates();
    await getmemories();
    await getUSer();
    Get.put<MyMemoryController>( MyMemoryController());
    isloading.value = false;
    super.onInit();
  }

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxList<MemoryModel> memories = <MemoryModel>[].obs;
  RxList<MemoriesDatesModels> memoriesDates = <MemoriesDatesModels>[].obs;

  RxBool isloading = false.obs;
  late CalendarController calendarController;

  Future<void> callMemoriesDates() async {
    Response? response =
        await ApiService.getRequest(ApiConstants.getMemoriesDates);
    if (response != null) {
      memoriesDates.clear();
      List<Map<String, dynamic>> memoryDatesList =
          List<Map<String, dynamic>>.from(response.data);
      memoriesDates.addAll(memoryDatesList
          .map((date) => MemoriesDatesModels.fromJson(date))
          .toList());
    }
    print(memoriesDates);
  }

  Future<void> getmemories({String? year, String? month, String? day}) async {
    ColoredPrint.green("Fetching Memories");
    isloading.value = true;
    ColoredPrint.green(
        "Month: ${calendarController.focusedDay.value.month} Year: ${calendarController.focusedDay.value.year}");
    Response? response = await ApiService.getRequest(
        ApiConstants.getAllMemories,
        queryParameters: {
          "month": calendarController.focusedDay.value.month.toString(),
          "year": calendarController.focusedDay.value.year.toString(),
          "date": calendarController.focusedDay.value.day.toString(),
          // "search": "all",
          "status": "all",
          "favorites": "all",
          "recipient": "all"
        });
    if (response != null) {
      List<Map<String, dynamic>> memoryList =
          List<Map<String, dynamic>>.from(response.data["memories"]);
      memories.clear();
      memories.addAll(memoryList
          .map((memoryData) => MemoryModel.fromJson(memoryData))
          .toList());
      isloading.value = false;
    }
  }

  Future<void> reload() async {
    await getmemories();
    await callMemoriesDates();
    await getUSer();
  }

  Future<void> getUSer() async {
    ColoredPrint.green("Fetching User Details");
    Response? response = await ApiService.getRequest(
      ApiConstants.getUserDetails,
    );
    if (response != null) {
      final jsonResponse = response.data["data"];
      // ColoredPrint.green(jsonResponse.toString());
      user.value = UserModel.fromJson(jsonResponse);
    }
  }

/*
  saveUser(Map<String, dynamic> data) async {
    ColoredPrint.green("Saving User Details");
    user.value = UserModel.fromJson(data["data"]);
  }
*/

  Future<void> downloadImages(List<String> urls) async {
    // Get the device's temporary directory
    final Directory tempDir = await getTemporaryDirectory();

    for (String url in urls) {
      // Extract the image file name from the URL
      final String fileName = url.split('/').last;

      // Define the local file path
      final File file = File('${tempDir.path}/$fileName');

      // Make a GET request to download the image
      final Response? response = await ApiService.getRequest(url);

      if (response != null && response.statusCode == 200) {
        // await file.writeAsBytes(response.bodyBytes);
        print('Downloaded: ${file.path}');
      }
    }
  }
}
