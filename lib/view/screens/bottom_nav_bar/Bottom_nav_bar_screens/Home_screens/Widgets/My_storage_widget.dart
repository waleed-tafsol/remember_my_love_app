import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../constants/TextConstant.dart';
import '../../../../../../constants/colors_constants.dart';
import '../../../../../../utills/data_storage_calculation.dart';
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
          controller.user.value?.ultimateStorage ?? false
              ? null
              : Get.toNamed(ChooseYourPlanScreen.routeName, arguments: {
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
                  return controller.user.value == null
                      ? Shimmer.fromColors(
                          baseColor: AppColors.kgradientBlue,
                          highlightColor: AppColors.kgradientPurple,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            height: 1.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ))
                      : controller.user.value?.ultimateStorage ?? false
                          ? Text(
                              "Unlimited",
                              style:
                                  TextStyleConstants.bodyMediumWhite(context),
                            )
                          : Text(
                              "${storageSizeUnit((controller.user.value?.package?.storage ?? 0) - (controller.user.value?.availableStorage ?? 0))} of ${storageSizeUnit(controller.user.value?.package?.storage ?? 0)} Used",
                              style:
                                  TextStyleConstants.bodyMediumWhite(context),
                            );
                }),
                k1hSizedBox,
                Obx(() {
                  return controller.user.value == null
                      ? Shimmer.fromColors(
                          baseColor: AppColors.kgradientBlue,
                          highlightColor: AppColors.kgradientPurple,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            height: 1.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ))
                      : controller.user.value?.ultimateStorage ?? false
                          ? const SizedBox()
                          : Text(
                              "♕ Upgrade to Premium ↗",
                              style: TextStyleConstants.bodyMediumWhite(context)
                                  .copyWith(
                                      // decoration: TextDecoration.underline,
                                      color: Colors.amber),
                            );
                }),
                Container(
                  margin: EdgeInsets.only(top: 1.h),
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
              final used = availableStorage / totalStorage;
              final percentUsed = (1 - used) * 100;
              return controller.user.value == null
                  ? Shimmer.fromColors(
                      baseColor: AppColors.kgradientBlue,
                      highlightColor: AppColors.kgradientPurple,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        height: 10.h,
                        width: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ))
                  : controller.user.value?.ultimateStorage ?? false
                      ? const SizedBox()
                      : CircularPercentIndicator(
                          radius: 5.h,
                          lineWidth: 5.0,
                          percent: 1 - used,
                          center: controller.user.value == null
                              ? Shimmer.fromColors(
                                  baseColor: AppColors.kgradientBlue,
                                  highlightColor: AppColors.kgradientPurple,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 1.w),
                                    height: 1.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ))
                              : Text(
                                  "${percentUsed > 1 ? percentUsed.toInt() : percentUsed.toStringAsFixed(2)}%"),
                          progressColor: Colors.white,
                        );
            }),
          ],
        ),
      ),
    );
  }
}
