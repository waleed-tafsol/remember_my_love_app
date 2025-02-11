import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Privacy_policy_controller.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});
  static const routeName = "PrivacyPolicyScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : WebViewWidget(
                controller: controller.webViewController,
              );
      }),
    );
  }
}
