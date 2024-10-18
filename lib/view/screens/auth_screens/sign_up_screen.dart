import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:remember_my_love_app/view/screens/onboarding_screens/onboarding_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
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
                Get.toNamed(OnboardingScreen.routeName);
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

class GradientButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final List<Color> gradients;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.gradients,
    this.textColor,
  }) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Calculate the colors for the gradient based on animation value
          Color startColor = widget.gradients[0];
          Color endColor = widget.gradients[1];
          Color animatedColor =
              Color.lerp(startColor, endColor, _animation.value)!;

          return Container(
            height: kButtonHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [animatedColor, endColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor ?? Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
