import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/ApiConstant.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../view/screens/bottom_nav_bar/Bottom_nav_bar_screens/My_memories_screen/SuccesScreen.dart';

class Paymentwebviewcontroller extends GetxController {
  RxBool isLoading = true.obs;
  late WebViewController controller;
  HomeScreenController homeController = Get.find();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    controller = WebViewController()
      ..setBackgroundColor(Colors.indigo[900]!)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally update a progress indicator here
          },
          onPageStarted: (String url) {
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false; // Stops the loading indicator
          },
          onHttpError: (HttpResponseError error) {
            // Handle HTTP errors
            isLoading.value = false; // Stops the loading indicator
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors
          },
          onNavigationRequest: (NavigationRequest request) {
            ColoredPrint.green(request.url);
            if (request.url == "${ApiConstants.baseUrl}payment-success") {
              homeController.getUSer();
              Get.offNamedUntil(
                  SuccessScreen.routeName,
                  (route) =>
                      route.settings.name == BottomNavBarScreen.routeName,
                  arguments: {
                    "title": "Success",
                    "subTitle": "Payment has been done successfully.",
                  });
            } else if (request.url ==
                "${ApiConstants.baseUrl}card-attach/success") {
              Get.offNamedUntil(
                  SuccessScreen.routeName,
                  (route) =>
                      route.settings.name == BottomNavBarScreen.routeName,
                  arguments: {
                    "title": "Success",
                    "subTitle": "Card has been attached successfully.",
                  });
            } else {
              CustomSnackbar.showError("Error", "Error in Payment");
              Get.back();
            }
            if (request.url.startsWith(args)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(args));
  }
}
