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

class ForgotPassScreen extends GetView<AuthController> {
  ForgotPassScreen({super.key});
  static const routeName = "ForgotPassScreen";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Otpcontroller otpController = Get.find();
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Obx(() {
                          return TextFormField(
                            decoration: InputDecoration(
                                hintText:
                                    "Password will be sent to given email",
                                errorText: controller.emailError.value),
                            onChanged: (value) {
                              _formKey.currentState!.validate();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!GetUtils.isEmail(value)) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            controller: otpController.forgotemailController,
                          );
                        })
                      ],
                    ),
                  ),
                ],
              )),
          const Spacer(),
          k1hSizedBox,
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  otpController.forgot_pass();
                }
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
