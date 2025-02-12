import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
// Import for iOS/macOS features.


class TermsAndConditionController extends GetxController {
  RxBool isLoading = false.obs;
  InAppWebViewController? webViewController;

/* @override
  void onInit() {
    super.onInit();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    webController =  WebViewController.fromPlatformCreationParams(params);

    webController
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
                  .startsWith('https://')) {
                return NavigationDecision.navigate;
              }
              return NavigationDecision.prevent;
            },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://remember-my-love-admin.vercel.app/terms-and-condition'));
  }*/
}
