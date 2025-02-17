import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import '../constants/ApiConstant.dart';
import '../models/MemoryModel.dart';
import '../models/NotificationModel.dart';
import '../services/ApiServices.dart';
import '../utills/Colored_print.dart';
import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import 'Bottom_nav_bar_controller.dart';

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool unRead = false.obs;
  RxList<NotificationModel> notification = <NotificationModel>[].obs;
  late HomeScreenController homeScreenController;
  @override
  void onInit() async {
    homeScreenController = Get.find();
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
      // Get.back();
      Get.until((route) => route.settings.name == BottomNavBarScreen.routeName);

      // CustomSnackbar.showError('Error', e.toString());
      isLoading.value = false;
    }
  }

  Future<void> callSeen(String id) async {
    try {
      await ApiService.patchRequest(
          ApiConstants.seenNotification, {"notificationId": id});
      for (var e in notification) {
        e.sId == id ? e.seen = true : null;
      }
    } catch (e) {
      ColoredPrint.red(e.toString());
    }
  }

  void handleNotification(RemoteMessage message) {
    final BottomNavController bottomNavController = Get.find();
    bottomNavController.unreadNotification.value = true;
    try {
      Map<String, dynamic> jsondata = jsonDecode(message.data["payload"]);

      final receivedNotification = NotificationModel.fromJson(jsondata);
      notification.insert(0, receivedNotification);
      if (message.data["flag"] == "memory") {
        HomeScreenController homeScreenController = Get.find();
        homeScreenController.getUSer();
        homeScreenController.getmemories();
        CustomSnackbar.showSuccess(
          receivedNotification.title!,
          receivedNotification.message!,
          // icon: Icons.notifications,
          onTap: (snack) {
            BottomNavController bottomNavController = Get.find();
            bottomNavController.changeTab(3);
            Get.until(
              (route) => route.settings.name == BottomNavBarScreen.routeName,
            );
          },
        );
      }
    } catch (e) {
      ColoredPrint.red("Error handling notification: $e");
    }
  }
}
