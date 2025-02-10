import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyController extends GetxController {
  late WebViewController webViewController;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    webViewController = WebViewController()
      ..setBackgroundColor(Colors.indigo[900]!)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
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
          'https://remember-my-love-admin.vercel.app/privacy-policy'));
    super.onInit();
  }
}
