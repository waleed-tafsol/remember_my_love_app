import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/forgot_pass_screen.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';
import 'package:remember_my_love_app/view/widgets/Glass_text_field_with_text_widget.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/Custom_glass_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  bool _showText = false;
  bool _animateWobal = false;
  bool _animation2 = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: -1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _startAnimation();
  }

  void _startAnimation() async {
    await _controller.forward();

    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    await _controller.reverse();
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    await _controller.forward();

    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    setState(() {
      _showText = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 50),
    );
    setState(() {
      _animateWobal = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AuthController authController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AnimatedAlign(
        curve: Curves.elasticIn,
        duration: const Duration(milliseconds: 2000),
        onEnd: () {
          setState(() {
            _animation2 = true;
          });
        },
        alignment: _showText ? Alignment.topCenter : Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 1,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.rotationY(_flipAnimation.value * 3.14159),
                      child: _showText
                          ? AnimatedContainer(
                              curve: Curves.elasticIn,
                              duration: const Duration(milliseconds: 500),
                              height: _animateWobal ? 10.h : 5.h,
                              child: Image.asset(
                                Image_assets.logo,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : _flipAnimation.value > -0.5
                              ? Image.asset(Image_assets.animation_cloud_back)
                              : AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: _animateWobal ? 0 : 1,
                                  child: Image.asset(
                                      Image_assets.animation_cloud_front)),
                    );
                  }),
            ),
            // Animate position based on _positionAnimation
            AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _showText ? 1 : 0,
                child: Text(
                  "Remember My\nLove",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Bookos',
                      color: Colors.white,
                      fontSize: 20.sp),
                )),

            AnimatedContainer(
              height: _animation2 ? 62.h : 0,
              width: _animation2 ? double.maxFinite : 0,
              duration: const Duration(milliseconds: 2000),
              child: Column(children: [
                Expanded(
                  child: CustomGlassmorphicContainer(
                      width: _animation2 ? double.maxFinite : 0,
                      height: _animation2 ? double.maxFinite : 0,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome Back!",
                              style: TextStyleConstants.displayMediumWhite(
                                  context),
                            ),
                            k1hSizedBox,
                            Text(
                              "Please Sign in to Continue your journey.",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            k1hSizedBox,
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Email")),
                            k1hSizedBox,
                            Obx(() {
                              return TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (!GetUtils.isEmail(value)) {
                                    return 'Invalid Email';
                                  }
                                  return null;
                                },
                                controller: authController.emailController,
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  errorText: authController.emailError.value,
                                ),
                              );
                            }),
                            k1hSizedBox,
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Password")),
                            k1hSizedBox,
                            Obx(() {
                              return TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  return null;
                                },
                                controller: authController.passwordController,
                                obscureText:
                                    !authController.passwordVisibility.value,
                                decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    errorText:
                                        authController.passwordError.value,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          authController
                                                  .passwordVisibility.value =
                                              !authController
                                                  .passwordVisibility.value;
                                        },
                                        icon: Icon(authController
                                                .passwordVisibility.value
                                            ? Icons.visibility
                                            : Icons.visibility_off))),
                              );
                            }),
                            k1hSizedBox,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_box_outline_blank,
                                  ),
                                  k1wSizedBox,
                                  Text(
                                    "Remember me",
                                    style: TextStyleConstants.bodyMediumWhite(
                                        context),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(ForgotPassScreen.routeName);
                                    },
                                    child: Text(
                                      "Forgot Password",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: Colors.white,
                                  height: 0.1.h,
                                )),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Text("Or",
                                      style: TextStyleConstants.bodyLargeWhite(
                                          context)),
                                ),
                                Expanded(
                                    child: Container(
                                  color: Colors.white,
                                  height: 0.1.h,
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    authController.loginWithGoogle();
                                  },
                                  child: CustomGlassButton(
                                    child: SvgPicture.asset(SvgAssets.google),
                                  ),
                                )),
                                k2wSizedBox,
                                Expanded(
                                    child: CustomGlassButton(
                                  child: SvgPicture.asset(SvgAssets.apple),
                                )),
                              ],
                            ),
                            k1hSizedBox,
                            IntrinsicWidth(
                              child: GestureDetector(
                                onTap: () {
                                  authController.loginFingerPrint();
                                },
                                child: CustomGlassButton(
                                  padding: EdgeInsets.all(2.w),
                                  borderRadius: BorderRadius.circular(50),
                                  child: Icon(
                                    size: 6.h,
                                    Icons.fingerprint_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            k1hSizedBox,
                            Text(
                              "Sign In with Touch ID",
                              style: TextStyleConstants.bodySmallWhite(context),
                            )
                          ],
                        ),
                      )),
                ),
                // k1hSizedBox,
                GestureDetector(
                  onTap: () {
                    Get.toNamed(SignUpScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyleConstants.bodySmallWhite(context),
                      ),
                      k1wSizedBox,
                      Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            k1hSizedBox,
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _showText ? 1 : 0,
              child: SizedBox(
                height: kButtonHeight,
                child: GradientButton(
                  onPressed: () {
                    // Get.offAndToNamed(BottomNavBarScreen.routeName);
                    if (_formKey.currentState!.validate()) {
                      authController.login();
                    }
                  },
                  gradients: const [Colors.purple, Colors.blue],
                  text: 'Sign In',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGlassButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding; // Make padding optional
  final BorderRadius? borderRadius; // Make borderRadius optional
  final VoidCallback? onTap;

  const CustomGlassButton({
    super.key,
    required this.child,
    this.padding, // Use this to declare as optional
    this.borderRadius,
    this.onTap, // Use this to declare as optional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 2.h), // Use default if null
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ?? BorderRadius.circular(20), // Use default if null
        color: AppColors.kGlassColor,
      ),
      child: Center(
        child: child, // Display the provided child
      ),
    );
  }
}
