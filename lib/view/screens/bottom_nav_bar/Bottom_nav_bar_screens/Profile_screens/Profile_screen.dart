import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/EditProfileScreen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/FingerPrintScreen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Privacy_policy_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Terms_and_condition_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/update_password_screen.dart';
import 'package:remember_my_love_app/view/widgets/CachedNetworkImageWidget.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../constants/colors_constants.dart';
import '../../../../widgets/CustomGlassDailogBox.dart';
import '../Home_screens/Widgets/My_storage_widget.dart';

class ProfileScreen extends GetView<HomeScreenController> {
  const ProfileScreen({super.key});

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GlassMorphicDailogBox(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              k2hSizedBox,
              Text(
                'Are you sure you want to delete your account? This action is irreversible.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              k1hSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      authService
                          .deleteAccount(controller.user.value?.sId ?? "");
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return controller.getUSer();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile",
                style: TextStyleConstants.displayMediumWhite(context)),
            k2hSizedBox,
            CustomGlassmorphicContainer(
                child: InkWell(
              onTap: () {
                Get.toNamed(EditProfileScreen.routeName);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 6.2.h,
                    backgroundColor: Colors.white,
                    child: Obx(() {
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
                          : ClipOval(
                              child: CachedNetworkImageWidget(
                              imageUrl: controller.user.value?.photo ?? "",
                              height: 12.h,
                              width: 12.h,
                              fit: BoxFit.cover,
                            ));
                    }),
                  ),
                  k2hSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return controller.user.value == null
                            ? Shimmer.fromColors(
                                baseColor: AppColors.kgradientBlue,
                                highlightColor: AppColors.kgradientPurple,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                                  height: 4.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ))
                            : Text(
                                controller.user.value?.name ?? "------ ----",
                                style:
                                    TextStyleConstants.displayMediumWhiteBold(
                                        context),
                              );
                      }),
                      k3wSizedBox,
                      SvgPicture.asset(SvgAssets.edit)
                    ],
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
                        : Text(
                            "Email:   ${controller.user.value?.email ?? "xyz@mail.com"}",
                            style: TextStyleConstants.bodyMediumWhite(context),
                          );
                  }),
                ],
              ),
            )),
            const My_storage_widget(),
            k1hSizedBox,
            controller.user.value?.platform == "email"
                ? CustomGlassmorphicContainer(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(UpdatePasswordScreen.routeName);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.visibility_off,
                            color: Colors.white,
                          ),
                          k3wSizedBox,
                          Text(
                            "Change Password",
                            style: TextStyleConstants.bodyMediumWhite(context),
                          ),
                        ],
                      ),
                    ))
                : const SizedBox(),
            k2hSizedBox,
            CustomGlassmorphicContainer(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(PrivacyPolicyScreen.routeName);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.white,
                      ),
                      k3wSizedBox,
                      Text(
                        "Privacy Policy",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                    ],
                  ),
                )),
            k2hSizedBox,
            CustomGlassmorphicContainer(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(TermsAndConditionScreen.routeName);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: Colors.white,
                      ),
                      k3wSizedBox,
                      Text(
                        "Terms and Conditions",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                    ],
                  ),
                )),
            k2hSizedBox,
            CustomGlassmorphicContainer(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(FingerPrintScreen.routeName);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                      ),
                      k3wSizedBox,
                      Text(
                        "FingerPrint",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                    ],
                  ),
                )),
           /* k2hSizedBox,
            CustomGlassmorphicContainer(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(CardsScreen.routeName);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.credit_card_outlined,
                        color: Colors.white,
                      ),
                      k3wSizedBox,
                      Text(
                        "Payment",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                    ],
                  ),
                )),*/
            k2hSizedBox,
            // PayButton()
            // k2hSizedBox,
            // SizedBox(
            //   height: 10.h,
            //   child: PlatformPayButton(
            //     type: PlatformButtonType.buy,
            //     onPressed: () {
            //       startGooglePay();
            //     },
            //   ),
            // ),
            // k2hSizedBox,
            CustomGlassmorphicContainer(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: InkWell(
                  onTap: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      k3wSizedBox,
                      Text(
                        "Delete Account",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                    ],
                  ),
                )),
            k2hSizedBox,
            CustomGlassmorphicContainer(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: InkWell(
                  onTap: () {
                    final HomeScreenController homeController = Get.find();
                    authService.logout(
                        platform: homeController.user.value?.platform);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      k3wSizedBox,
                      Text(
                        "Logout",
                        style: TextStyleConstants.bodyMediumWhite(context),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

/*
  Future<void> startGooglePay() async {
    final googlePaySupported = await Stripe.instance
        .isPlatformPaySupported(googlePay: const IsGooglePaySupportedParams());
    if (googlePaySupported) {
      try {
        // final response = await fetchPaymentIntentClientSecret();
        // final clientSecret = response['clientSecret'];
        // 2.present google pay sheet
        await Stripe.instance.confirmPlatformPayPaymentIntent(
            clientSecret: "clientSecret",
            confirmParams: const PlatformPayConfirmParams.googlePay(
              googlePay: GooglePayParams(
                testEnv: true,
                merchantName: 'Example Merchant Name',
                merchantCountryCode: 'Es',
                currencyCode: 'EUR',
              ),
            )
            // PresentGooglePayParams(clientSecret: clientSecret),
            );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text('Google Pay payment succesfully completed')),
        // );
      } catch (e) {
        if (e is StripeException) {
          // log('Error during google pay',
          //     error: e.error, stackTrace: StackTrace.current);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Error: ${e.error}')),
          // );
        } else {
          // log('Error during google pay',
          //     error: e, stackTrace: (e as Error?)?.stackTrace);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Error: $e')),
          // );
        }
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //       content: Text('Google pay is not supported on this device')),
      // );
    }
  }
*/
}
