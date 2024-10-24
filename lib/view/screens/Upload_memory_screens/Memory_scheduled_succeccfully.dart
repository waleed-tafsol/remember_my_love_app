import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/constants.dart';
import '../bottom_nav_bar/Bottom_nav_bar.dart';

class MemoryScheduledSucceccfully extends StatelessWidget {
  const MemoryScheduledSucceccfully({super.key});
  static const routeName = "MemoryScheduledSucceccfully";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 500)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading animation
                return SizedBox(
                  height: 30.h,
                );
              } else {
                return Lottie.asset(
                  LottieAssets.loading,
                  height: 30.h,
                  fit: BoxFit.cover,
                  repeat: false,
                  animate: true,
                );
                // Show another animation after loading
              }
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Memory Schedule Successful",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          k1hSizedBox,
          Text(
            " It is a long established fact that a reader will be distracted"
            " by the readable content of a page when looking at its layout.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                Get.until((route) =>
                    route.settings.name == BottomNavBarScreen.routeName);
              },
              text: 'Continue',
              textColor: Colors.lightBlue[900],
              gradients: const [
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
