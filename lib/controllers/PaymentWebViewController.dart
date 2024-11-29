import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Paymentwebviewcontroller extends GetxController {
  RxBool isLoading = true.obs;
  late WebViewController controller;

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
