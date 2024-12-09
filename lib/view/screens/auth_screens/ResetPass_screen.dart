import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';
import 'package:remember_my_love_app/controllers/OtpController.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/assets.dart';
import '../../../constants/constants.dart';

class ResetpassScreen extends GetView<Otpcontroller> {
  const ResetpassScreen({super.key});
  static const routeName = "ResetPassScreen";
  static RxBool passwordVisibility = false.obs;
  @override
  Widget build(BuildContext context) {
    final Otpcontroller otpcontroller = Get.find();
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
                        "New Password",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Obx(() {
                        return TextField(
                          onChanged: (value) {
                            authController.signupValidateForm();
                          },
                          controller: otpcontroller.newresetpassController,
                          obscureText: !authController.passwordVisibility.value,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              errorText: authController.passwordError.value,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    authController.passwordVisibility.value =
                                        !authController
                                            .passwordVisibility.value;
                                  },
                                  icon: Icon(
                                      authController.passwordVisibility.value
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                        );
                      })
                    ],
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Confirm Password",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Obx(() {
                        return TextField(
                          onChanged: (value) {
                            //authController.signupValidateForm();
                          },
                          controller: otpcontroller.newpasscnfrmController,
                          obscureText: !authController.passwordVisibility.value,
                          decoration: InputDecoration(
                              hintText: "Enter Password again",
                              errorText: authController.passwordError.value,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    authController.passwordVisibility.value =
                                        !authController
                                            .passwordVisibility.value;
                                  },
                                  icon: Icon(
                                      authController.passwordVisibility.value
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
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
                controller.resetPass();
              },
              text: 'Reset Password',
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
