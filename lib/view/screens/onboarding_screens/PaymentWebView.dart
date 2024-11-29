import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/PaymentWebViewController.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/custom_scaffold.dart';

class PaymentScreen extends GetView<Paymentwebviewcontroller> {
  const PaymentScreen({super.key});

  static const routeName = "PaymentScreen";

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
