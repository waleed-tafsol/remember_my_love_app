import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';
import 'package:remember_my_love_app/controllers/OtpController.dart';
import 'package:remember_my_love_app/controllers/forgotPass_controller.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/OTP_screen.dart';
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

class ForgotPassScreen extends GetView<Otpcontroller> {
  const ForgotPassScreen({super.key});
  static const routeName = "ForgotPassScreen";
  @override
  Widget build(BuildContext context) {
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
                    "Forgot Password ??",
                    style: TextStyleConstants.displayMediumWhite(context),
                  ),
                  k2hSizedBox,
                  Text(
                    "Here to help you",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Obx(() {
                        return TextField(
                          decoration: InputDecoration(
                              hintText: "Password will be sent to given email",
                              errorText: authController.emailError.value),
                          onChanged: (value) {
                            authController.validateemail(value);
                          },
                          controller: controller.forgotemailController,
                        );
                      })
                    ],
                  ),
                ],
              )),
          const Spacer(),
          k1hSizedBox,
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                controller.forgot_pass();
              },
              text: 'Send Password',
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
