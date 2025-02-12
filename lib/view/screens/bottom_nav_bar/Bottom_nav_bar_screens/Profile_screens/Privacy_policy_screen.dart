import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remember_my_love_app/controllers/Privacy_policy_controller.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'dart:collection';

import '../../../../../constants/assets.dart';
import '../../../../widgets/in_app_web_view_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const routeName = "PrivacyPolicyScreen";

  @override
  Widget build(BuildContext context) {
    return InAppWebViewWidget(url: 'https://remember-my-love-admin.vercel.app/privacy-policy');
  }
}
