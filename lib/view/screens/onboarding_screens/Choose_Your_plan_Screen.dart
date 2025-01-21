import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controllers/Choose_your_plan_controller.dart';
import '../../../utills/TextUtills.dart';
import '../../widgets/Custom_glass_container.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import 'PaymentScreen.dart';

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
          Align(
            alignment: Alignment.topLeft,
            child: CustomRoundedGlassButton(
                icon: Icons.arrow_back_ios_new,
                ontap: () {
                  Get.back();
                }),
          ),
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
                                    capitalize(e.packageType ?? ""),
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
            return (controller.homeController.user.value?.package?.sId ==
                            controller.selectedPackage.value?.sId ||
                        controller.selectedPackage.value?.packageType ==
                            "free") ||
                    controller.isLoading.value
                ? const SizedBox()
                : controller.homeController.user.value?.package?.packageType ==
                        "free"
                    ? GradientButton(
                        onPressed: () async {
                          await controller.buyPackage();
                        },
                        text: "Select Subscription",
                        gradients: const [Colors.purpleAccent, Colors.blue])
                    : GradientButton(
                        onPressed: () async {
                          // await controller.updateSubscription(
                          //     controller.selectedPackage.value?.sId ?? "");
                          Get.toNamed(PaymentScreen.routeName, arguments: {
                            "renewUpdateOrBuySub": "Update",
                            "package": controller.selectedPackage.value
                          });
                          // await controller.buyPackage(
                          //     controller.selectedPackage.value?.sId ?? "");
                        },
                        text: "Update Subscription",
                        gradients: const [Colors.purpleAccent, Colors.blue]);
          }),
          k2hSizedBox,
          Obx(() {
            final user = controller.homeController.user.value;
            if (user == null || user.subscriptionDueDate == null) {
              return SizedBox();
            }

            final subDueDate = DateTime.parse(user.subscriptionDueDate ?? "");
            final isBefore = DateTime.now().isBefore(subDueDate);
            final isCancelled = user.subscriptionStatus == "canceled";

            // If package is different or still loading, no button is shown
            if (controller.homeController.user.value?.package?.sId !=
                    controller.selectedPackage.value?.sId ||
                controller.isLoading.value) {
              return SizedBox();
            }

            return GradientButton(
              onPressed: () async {
                if (isCancelled) {
                  if (isBefore) {
                    // controller.renewSubscription();
                    Get.toNamed(PaymentScreen.routeName, arguments: {
                      "renewUpdateOrBuySub": "Renew",
                      "package": controller.selectedPackage.value
                    });
                    // await controller.buyPackage(
                    //     controller.selectedPackage.value?.sId ?? "");
                  } else {
                    // controller.resumeSubscription();  // Optionally, resume before the due date
                  }
                } else {
                  controller.cancelSubscription();
                  // await controller
                  //     .buyPackage(controller.selectedPackage.value?.sId ?? "");
                }
              },
              text: isCancelled
                  ? (isBefore ? "Renew Subscription" : "")
                  : "Cancel Subscription",
              gradients: const [Colors.purpleAccent, Colors.blue],
            );
          })
        ],
      ),
    );
  }
}
