import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/CardsScreen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/Choose_your_plan_controller.dart';
import '../../widgets/Custom_glass_container.dart';

class ChooseYourPlanScreen extends GetView<ChooseYourPlanController> {
  ChooseYourPlanScreen({super.key});
  static const routeName = "ChooseYourPlanScreen";

  HomeScreenController homeController = Get.find();

  // bool _monthlySelected = true;
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    // if (arguments == null) {
    //   return const Center(
    //       child: Text('No arguments passed in choose your plan.'));
    // }
    return CustomScaffold(
      body: Column(
        children: [
          Text(
            arguments?["title"] ?? "Choose Your Plan",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          k1hSizedBox,
          Text(
            "Choose a Plan to Avail Special Features",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          k4hSizedBox,
          Obx(() {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: AppColors.kPrimaryColor, width: 2)),
                    // height: kButtonHeight,
                    // width: 60.w,
                    child: Wrap(
                      children: controller.packages
                          .map((e) => InkWell(
                                onTap: () {
                                  controller.selectedPackage.value = e;
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  // height: ,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedPackage.value?.sId ==
                                                e.sId
                                            ? AppColors.kPrimaryColor
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    e.packageType ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: controller.selectedPackage
                                                        .value?.sId ==
                                                    e.sId
                                                ? AppColors.kSecondaryColor
                                                : AppColors.kPrimaryColor),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
          }),
          SizedBox(
            height: 15.h,
          ),
          CustomGlassmorphicContainer(
            width: double.infinity,
            height: 20.h,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() {
                        return Text(
                          "\$${controller.selectedPackage.value?.price ?? 0}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Text(
                              controller.selectedPackage.value?.packageType ??
                                  "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            );
                          }),
                          SizedBox(
                            height: 0.5.h,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.kIconColor,
                      ),
                      k1wSizedBox,
                      Obx(() {
                        return Text(
                          "${controller.homeController.user.value?.package?.sId == controller.selectedPackage.value?.sId ? "" : "Get"} ${controller.selectedPackage.value?.summary ?? ""}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Obx(() {
            return controller.homeController.user.value?.package?.sId ==
                        controller.selectedPackage.value?.sId ||
                    controller.selectedPackage.value?.sId ==
                        "6711752199b2f80e34b6acf9"
                ? const SizedBox()
                : GradientButton(
                    onPressed: () {
                      // arguments["popAfterSuccess"] ?? false
                      //     ?
                      //  Get.toNamed(
                      //     ContinueScreen.routeName,
                      //     arguments: {
                      //       "title": "Congrats ",
                      //       "subtitle":
                      //           "Your Plan has been upgraded successfully",
                      //       "callback": () => Get.until((route) =>
                      //           Get.currentRoute ==
                      //           BottomNavBarScreen.routeName)
                      //     },
                      //   )
                      // : Get.offAllNamed(
                      //     ContinueScreen.routeName,
                      //     arguments: {
                      //       "title": "Grateful for Every Moment",
                      //       "subtitle": "We're excited to share that your picture will be the cover of a special"
                      //           "collection of cherished memories and videos, which will be delivered"
                      //           "to your loved ones at a time you choose, allowing you to share those precious moments with them.",
                      //       "callback": () =>
                      //           Get.toNamed(QuestionsScreen.routeName)
                      //     },
                      //   );
                      Get.toNamed(
                        CardsScreen.routeName,
                        arguments: controller.selectedPackage.value?.sId,
                      );
                      // controller.buyPackage();
                    },
                    text: "Select This Plan",
                    gradients: const [Colors.purpleAccent, Colors.blue]);
          }),
          k2hSizedBox,
          Obx(() {
            return controller.homeController.user.value?.package?.sId !=
                    controller.selectedPackage.value?.sId
                ? SizedBox()
                : GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      "Stick with ${(controller.homeController.user.value?.package?.storage ?? 0) / 1024} GB Free Plan",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
          })
        ],
      ),
    );
  }
}
