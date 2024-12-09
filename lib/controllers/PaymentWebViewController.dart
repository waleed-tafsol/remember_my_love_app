import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors
          },
          onNavigationRequest: (NavigationRequest request) {
            ColoredPrint.green(request.url);
            if (request.url ==
                "https://remember-my-love-c7798dc8cf7c.herokuapp.com/api/v1/payment-success") {
              CustomSnackbar.showSuccess("Success", "Payment Successful");
              homeController.getUSer();
              Get.offAllNamed(BottomNavBarScreen.routeName);
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
