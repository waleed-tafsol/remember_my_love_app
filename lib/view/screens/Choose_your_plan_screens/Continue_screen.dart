import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/constants.dart';
import '../auth_screens/sign_up_screen.dart';
import 'Choose_Your_plan_Screen.dart';

class ContinueScreen extends StatelessWidget {
  const ContinueScreen({super.key});
  static const routeName = "ContinueScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 20.h,
            width: 20.h,
            child: Lottie.asset(
              'assets/Lottie/loading.lottie',
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Welcome aboard!",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          k1hSizedBox,
          Text(
            " We're excited to share that your picture will"
            " be the cover of a special collection of cherished memories and videos,"
            " which will be delivered to your loved ones at a time you choose,"
            " allowing you to share those precious moments with them.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                Get.toNamed(BottomNavBarScreen.routeName);
              },
              text: 'Continue',
              textColor: Colors.lightBlue[900],
              gradients: [
                Colors.blue,
                Colors.white,
              ],
            ),
          )
        ],
      ),
    );
  }
}
