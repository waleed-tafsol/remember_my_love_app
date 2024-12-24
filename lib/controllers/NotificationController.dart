import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import '../constants/ApiConstant.dart';
import '../models/MemoryModel.dart';
import '../models/NotificationModel.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<NotificationModel> notification = <NotificationModel>[].obs;
  @override
  void onInit() async {
    await getNotification();
    super.onInit();
  }

  Future<void> getNotification() async {
    isLoading.value = true;

    try {
      ColoredPrint.green("getting Notification");
      Response? response = await ApiService.getRequest(
        ApiConstants.getAllNotification,
      );
      if (response != null) {
        final List<dynamic> jsonResponse =
            response.data["data"]["notifications"];

        notification.value =
            jsonResponse.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    } finally {
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
          ApiConstants.findMemories + imageKey.toString());
      if (response != null) {
        Get.back();
        final memory = MemoryModel.fromJson(response.data);
        Get.toNamed(
          MemoryDetailScreen.routeName,
          arguments: memory,
        );

        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      Get.back();
      Get.back();
      isLoading.value = false;
    }
  }
}
