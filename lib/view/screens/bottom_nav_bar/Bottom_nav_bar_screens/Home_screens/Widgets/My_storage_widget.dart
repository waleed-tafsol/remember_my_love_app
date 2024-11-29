import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../constants/TextConstant.dart';
import '../../../../../widgets/Custom_glass_container.dart';
import '../../../../onboarding_screens/Choose_Your_plan_Screen.dart';

class My_storage_widget extends GetView<HomeScreenController> {
  const My_storage_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGlassmorphicContainer(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Get.toNamed(ChooseYourPlanScreen.routeName, arguments: {
            "title": "Upgrade Your Plan",
            "popAfterSuccess": true
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "My Storage",
                  style: TextStyleConstants.headlineLargeWhite(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                k1hSizedBox,
                Obx(() {
                  return Text(
                    "${((controller.user.value?.package?.storage ?? 0) / 1024).toStringAsFixed(0)} GB of ${((controller.user.value?.availableStorage ?? 0) / 1024).toStringAsFixed(0)} GB Available",
                    style: TextStyleConstants.bodyMediumWhite(context),
                  );
                }),
                k1hSizedBox,
                Text(
                  "♕ Upgrade to Premium ↗",
                  style: TextStyleConstants.bodyMediumWhite(context).copyWith(
                      // decoration: TextDecoration.underline,
                      color: Colors.amber),
                ),
                Container(
                  width: 40.w,
                  color: Colors.amber,
                  height: 1,
                )
              ],
            ),
            Obx(() {
              final availableStorage =
                  controller.user.value?.availableStorage ?? 0;
              final totalStorage = controller.user.value?.package?.storage ?? 0;

              final percentUsed = availableStorage / totalStorage;
              final percentRemaining = percentUsed * 100;
              return CircularPercentIndicator(
                radius: 5.h,
                lineWidth: 5.0,
                percent: percentUsed,
                center: Text(
                    "${controller.isloading.value ? 0 : percentRemaining.toStringAsFixed(0)}%"),
                progressColor: Colors.white,
              );
            }),
          ],
        ),
      ),
    );
  }
}
