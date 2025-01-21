import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/add_card_screen.dart';

import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/ShimmerWidget.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../constants/TextConstant.dart';
import '../../../constants/constants.dart';
import '../../../controllers/PaymentController.dart';
import '../../widgets/Custom_rounded_glass_button.dart';
import '../../widgets/custom_scaffold.dart';

class PaymentScreen extends GetView<Paymentcontroller> {
  const PaymentScreen({super.key});

  static const routeName = "PaymentScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        body: SingleChildScrollView(
          child: Column(
            children: [
              k2hSizedBox,
              Row(
                children: [
                  CustomRoundedGlassButton(
                      icon: Icons.arrow_back_ios_new,
                      ontap: () {
                        Get.back();
                      }),
                  k2wSizedBox,
                  Text("Buy Plan",
                      style: TextStyleConstants.headlineLargeWhite(context)),
                  const Spacer(),
                ],
              ),
              k2hSizedBox,
              CustomGlassmorphicContainer(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        return !controller.isLoading.value &&
                                controller.defaultCard.value?.card == null
                            ? const SizedBox.shrink()
                            : CustomGlassmorphicContainer(
                                height: 25.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Default Card",
                                      style: TextStyle(
                                          // fontFamily: 'Bookos',
                                          color: Colors.white,
                                          fontSize: 14.sp),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    controller.isLoading.value
                                        ? ShimmerWidget(
                                            height: 2.h, width: double.infinity)
                                        : Text(
                                            "•••• •••• •••• ${controller.defaultCard.value?.card.last4}",
                                            style: TextStyle(
                                                // fontFamily: 'Bookos',
                                                color: Colors.white,
                                                fontSize: 20.sp),
                                          ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            controller.isLoading.value
                                                ? ShimmerWidget(
                                                    height: 2.h, width: 10.w)
                                                : Text(
                                                    "${controller.defaultCard.value?.card.expMonth.toString() ?? "12"}/${controller.defaultCard.value?.card.expYear.toString() ?? "2022"}",
                                                    style: TextStyle(
                                                        // fontFamily: 'Bookos',
                                                        color: Colors.white,
                                                        fontSize: 12.sp),
                                                  ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            controller.isLoading.value
                                                ? ShimmerWidget(
                                                    height: 2.h, width: 30.w)
                                                : Text(
                                                    controller.defaultCard.value
                                                            ?.name ??
                                                        "",
                                                    style: TextStyle(
                                                        // fontFamily: 'Bookos',
                                                        color: Colors.white,
                                                        fontSize: 14.sp),
                                                  ),
                                          ],
                                        ),
                                        controller.isLoading.value
                                            ? ShimmerWidget(
                                                height: 2.h, width: 10.w)
                                            : Text(
                                                controller.defaultCard.value
                                                        ?.card.displayBrand ??
                                                    "visa",
                                                style: TextStyle(
                                                    // fontFamily: 'Bookos',
                                                    color: Colors.white,
                                                    fontSize: 20.sp),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      Obx(() {
                        return controller.isLoading.value
                            ? ShimmerWidget(height: 2.h, width: 20.w)
                            : Text(
                                controller.selectedPackage.title ?? "",
                                style: TextStyle(
                                    // fontFamily: 'Bookos',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.sp),
                              );
                      }),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() {
                        return controller.isLoading.value
                            ? ShimmerWidget(height: 2.h, width: 20.w)
                            : Text(
                                "\$ ${controller.selectedPackage.price}",
                                style: TextStyle(
                                    // fontFamily: 'Bookos',
                                    color: Colors.white,
                                    fontSize: 22.sp),
                              );
                      }),
                      SizedBox(
                        height: 4.h,
                      ),
                      Obx(() {
                        return controller.isLoading.value
                            ? ShimmerWidget(height: 2.h, width: 50.w)
                            : Text(
                                "${(controller.selectedPackage.storage! / 1024).toInt()} GB Storage",
                                style: TextStyle(
                                    // fontFamily: 'Bookos',
                                    color: Colors.white,
                                    fontSize: 12.sp),
                              );
                      }),
                      SizedBox(
                        height: 4.h,
                      ),

                      Obx(() {
                        return controller.isLoading.value
                            ? ShimmerWidget(height: 6.h, width: double.infinity)
                            : controller.defaultCard.value?.card != null
                                ? GradientButton(
                                    onPressed: () {
                                      switch (controller
                                          .renewUpdateOrBuySub.value) {
                                        case "Renew":
                                          controller.renewSubscription();
                                        case "Update":
                                          controller.updateSubscription();
                                        case "Buy":
                                          controller.buyPackage();
                                          break;
                                        default:
                                      }
                                    },
                                    text:
                                        "${controller.renewUpdateOrBuySub} Subscription",
                                    gradients: [Colors.purple, Colors.blue])
                                : const SizedBox();
                      }),

                      //                     ApplePayButton(
                      //   paymentConfiguration: PaymentConfiguration.fromJsonString(
                      //       defaultApplePayConfigString),
                      //   paymentItems: _paymentItems,
                      //   style: ApplePayButtonStyle.black,
                      //   type: ApplePayButtonType.buy,
                      //   margin: const EdgeInsets.only(top: 15.0),
                      //   onPaymentResult: onApplePayResult,
                      //   loadingIndicator: const Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              k2hSizedBox,
              InkWell(
                onTap: () {
                  Get.toNamed(AddCardScreen.routeName, arguments: true);
                },
                child: Text(
                  "Attatch Card +",
                  style: TextStyle(
                    fontSize: 15.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              // SizedBox(
              //   height: 4.h,
              // ),
              // GooglePayButton(
              //   paymentConfiguration: PaymentConfiguration.fromJsonString(
              //       controller.defaultGooglePay),
              //   paymentItems: [
              //     PaymentItem(
              //         amount: controller.selectedPackage.price.toString(),
              //         label: controller.selectedPackage.title ?? "")
              //   ],
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15.0),
              //   onPaymentResult: controller.onGooglePayResult,
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
