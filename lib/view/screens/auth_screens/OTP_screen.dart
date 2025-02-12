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

class OtpScreen extends GetView<Otpcontroller> {
  OtpScreen({super.key});
  static const routeName = "OtpScreen";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New One-Time Password",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Obx(() {
                          return TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter One-Time Password";
                              } else if (value.length < 6 ||
                                  !value.isNumericOnly) {
                                return "Please enter valid One-Time Password";
                              }
                              return null;
                            },
                            controller: controller.newpassController,
                            decoration: InputDecoration(
                                hintText: "Enter One-Time Password",
                                errorText: authController.emailError.value),
                            /* onChanged: (value) {
                              authController.validateemail(value);
                            }, */
                            // controller: otpcontroller.,
                          );
                        })
                      ],
                    ),
                  ),
                  k1hSizedBox,
                  Obx(() => Text(
                        'Resend One-Time Password in: ${controller.formatTime(controller.remainingSeconds.value)}',
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
                              ? 'Resend One-Time Password'
                              : 'Resend One-Time Password',
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
                if (_formKey.currentState!.validate()) {
                  controller.verifyOtp();
                }
              },
              text: 'verify One-Time Password',
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
