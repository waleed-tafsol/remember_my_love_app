import 'package:flutter/material.dart';
import '../../../../widgets/in_app_web_view_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const routeName = "PrivacyPolicyScreen";

  @override
  Widget build(BuildContext context) {
    return InAppWebViewWidget(url: 'https://remember-my-love-admin.vercel.app/privacy-policy');
  }
}
