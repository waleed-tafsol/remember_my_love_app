import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/Terms_and_condition_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../widgets/custom_scaffold.dart';

class TermsAndConditionScreen extends GetView<TermsAndConditionController> {
  const TermsAndConditionScreen({super.key});
  static const routeName = "TermsAndConditionScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : WebViewWidget(
                controller: controller.controller,
              );
      }),
    );
  }
}
