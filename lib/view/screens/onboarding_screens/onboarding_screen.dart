import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/splash_screens/Splah_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const routeName = "OnboardingScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Welcome aboard!",
            style: TextStyleConstants.displayMediumWhiteBold(context),
          ),
          k1hSizedBox,
          Text(
            "Welcome aboard!",
            style: TextStyleConstants.displayMediumWhiteBold(context),
          ),
        ],
      ),
    );
  }
}
