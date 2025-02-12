import 'package:flutter/material.dart';
import '../../../../widgets/in_app_web_view_widget.dart';


class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  static const routeName = "TermsAndConditionScreen";

  @override
  Widget build(BuildContext context) {
    return InAppWebViewWidget(url: 'https://remember-my-love-admin.vercel.app/terms-and-condition');
  }
}



