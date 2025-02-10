import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionController extends GetxController {
  RxBool isLoading = true.obs;
  late WebViewController controller;

  @override
  void onInit() {
    super.onInit();

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
              if (request.url
                  .startsWith('https://remember-my-love-admin.vercel.app/')) {
                return NavigationDecision.navigate;
              }
              return NavigationDecision.prevent;
            },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://remember-my-love-admin.vercel.app/terms-and-condition'));
  }
}
