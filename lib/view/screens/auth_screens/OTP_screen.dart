import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';
//import 'package:remember_my_love_app/controllers/Otpcontroller.dart';
import 'package:remember_my_love_app/controllers/OtpController.dart';
import 'package:remember_my_love_app/controllers/forgotPass_controller.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/ResetPass_screen.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Choose_Your_plan_Screen.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/Continue_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../controllers/Signup_controller.dart';

class OtpScreen extends GetView<Otpcontroller> {
  const OtpScreen({super.key});
  static const routeName = "OtpScreen";
  @override
  Widget build(BuildContext context) {
    final Otpcontroller otpcontroller = Get.find();
    final ForgotpassController forgotpassController = Get.find();
    final AuthController authController = Get.find();
    return CustomScaffold(
      body: Column(
        children: [
          Hero(
              transitionOnUserGestures: true,
              tag: 1,
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159),
                  child: Image.asset(
                    Image_assets.logo,
                  ))),
          Text(
            "Remember My\nLove",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Bookos', color: Colors.white, fontSize: 20.sp),
          ),
          CustomGlassmorphicContainer(
              width: double.maxFinite,
              // height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyleConstants.displayMediumWhite(context),
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Otp",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Obx(() {
                        return TextField(
                          controller: controller.newpassController,
                          decoration: InputDecoration(
                              hintText: "Enter Otp",
                              errorText: authController.emailError.value),
                          /* onChanged: (value) {
                            authController.validateemail(value);
                          }, */
                          // controller: otpcontroller.,
                        );
                      })
                    ],
                  ),
                  k1hSizedBox,
                  Obx(() => Text(
                        'Resend OTP in: ${controller.formatTime(controller.remainingSeconds.value)}',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      )),
                  k1hSizedBox,
                  Obx(() => GestureDetector(
                        onTap: controller.canResendOtp.value
                            ? controller.resendOtp
                            : null,
                        child: Text(
                          controller.canResendOtp.value
                              ? 'Resend OTP'
                              : 'Resend OTP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: controller.canResendOtp.value
                                ? Colors.blue
                                : Colors.grey,
                            decoration: controller.canResendOtp.value
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      )),
                ],
              )),
          const Spacer(),
          k1hSizedBox,
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                controller.verifyOtp();
              },
              text: 'verify OTP',
              gradients: const [
                Colors.purple,
                Colors.blue,
              ],
            ),
          )
        ],
      ),
    );
  }
}
