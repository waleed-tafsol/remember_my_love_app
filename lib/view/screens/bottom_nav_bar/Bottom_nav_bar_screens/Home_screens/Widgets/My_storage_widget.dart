import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/upgrade_plan_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../constants/TextConstant.dart';
import '../../../../../widgets/Custom_glass_container.dart';

class My_storage_widget extends StatelessWidget {
  const My_storage_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGlassmorphicContainer(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Get.toNamed(UpgradePlanScreen.routeName);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Storage",
                  style: TextStyleConstants.headlineLargeWhite(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "0.08 GB of 1 GB Used",
                  style: TextStyleConstants.bodyMediumWhite(context),
                ),
                Text(
                  "Upgrade to Premium",
                  style: TextStyleConstants.bodyMediumWhite(context).copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.amber),
                ),
              ],
            ),
            CircularPercentIndicator(
              radius: 5.h,
              lineWidth: 5.0,
              percent: 0.6,
              center: const Text("60%"),
              progressColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
