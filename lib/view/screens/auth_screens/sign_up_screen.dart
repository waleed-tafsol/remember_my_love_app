import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class SignUpScreen extends GetView<SignupController> {
  const SignUpScreen({super.key});
  static const routeName = "SignUpScreen";

  @override
  Widget build(BuildContext context) {
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
                      const TextField(
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
                      const TextField(
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
                      const TextField(
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
                      const TextField(
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            suffixIcon: Icon(Icons.visibility_off_outlined)),
                      ),
                    ],
                  ),
                ],
              )),
          const Spacer(),
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
                Get.offAllNamed(
                  ContinueScreen.routeName,
                  arguments: {
                    "title": "Welcome Aboard!",
                    "subtitle":
                        "We're grateful you've joined our community and taken the first step in preserving your family legacy.",
                    "callback": () {
                      Get.toNamed(ChooseYourPlanScreen.routeName,
                          arguments: {});
                    }
                  },
                );
              },
              text: 'Sign Up',
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
