import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/onboarding_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../controllers/Signup_controller.dart';

class SignUpScreen extends GetView<SignupController> {
  const SignUpScreen({super.key});
  static const routeName = "SignUpScreen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(
              width: 30.w,
              child: Hero(
                  transitionOnUserGestures: true,
                  tag: 1,
                  child: Image.asset(Image_assets.animation_cloud_front))),
          CustomGlassmorphicContainer(
              width: double.maxFinite,
              height: 60.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Setup Your Profile",
                    style: TextStyleConstants.displayMediumWhite(context),
                  ),
                  k2hSizedBox,
                  Text(
                    "Please Sign up to Start your journey.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Enter Name"),
                      ),
                    ],
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Enter Email"),
                      ),
                    ],
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            suffixIcon: Icon(Icons.visibility_off_outlined)),
                      ),
                    ],
                  ),
                  k1hSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            suffixIcon: Icon(Icons.visibility_off_outlined)),
                      ),
                    ],
                  ),
                ],
              )),
          k1hSizedBox,
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyleConstants.bodySmallWhite(context),
                ),
                k1wSizedBox,
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            ),
          ),
          k1hSizedBox,
          SizedBox(
            height: kButtonHeight,
            child: GradientButton(
              onPressed: () {
                Get.offAllNamed(OnboardingScreen.routeName);
              },
              text: 'Sign Up',
              gradients: [
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
