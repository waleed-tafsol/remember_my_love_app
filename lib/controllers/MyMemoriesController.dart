import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../constants/ApiConstant.dart';
import '../services/ApiServices.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';

class MyMemoryController extends GetxController {
  RxList<String> images = <String>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMemories();
  }

  List<String> filters = ["All", "Created for me", "Created by me"];
  RxString selectedFilter = "All".obs;

  void changeFilter(String value) {
    if (selectedFilter.value != value) {
      selectedFilter.value = value;
      fetchMemories();
    }
  }

  Future<void> fetchMemories() async {
    isLoading.value = true;
    try {
      final endpoint =
          '${ApiConstants.getAllMemoriesImages}${selectedFilter.value == "All" ? "" : selectedFilter.value == "Created for me" ? "?createdByYou=false" : "?createdByYou=true"}';
      Response? response = await ApiService.getRequest(endpoint);
      if (response != null) {
        List<dynamic> responseData = response.data["images"];
        images.clear();
        responseData.forEach((element) {
          images.add(element);
        });

        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> fetchMemoryAndPassItToDetailScreen(String? imageKey) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      Response? response = await ApiService.getRequest(
        ApiConstants.getMemoryDetailByImage + imageKey!,
      );
      if (response != null) {
        // Get.back();
        // final memory = MemoryModel.fromJson(response.data);
        Get.toNamed(
          MemoryDetailScreen.routeName,
          // arguments: memory,
        );

        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    } finally {
      Get.back();
    }
  }
}
