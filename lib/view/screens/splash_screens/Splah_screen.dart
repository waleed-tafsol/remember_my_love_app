import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late AnimationController _positionController;
  late Animation<double> _flipAnimation;
  // late Animation<double> _positionAnimation; // New animation for position
  bool _showText = false;
  bool _animation2 = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // _positionController = AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );

    // Flip animation
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Position animation for the text
    // _positionAnimation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.easeInOut,
    //   ),
    // );

    _startAnimation();
  }

  void _startAnimation() async {
    await _controller.forward();

    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    await _controller.reverse();
    await Future.delayed(
      const Duration(milliseconds: 200),
    );
    await _controller.forward();
    await Future.delayed(
      const Duration(milliseconds: 200),
    );
    setState(() {
      _showText = true;
    });

    // await Future.delayed(const Duration(milliseconds: 200));
    // _positionController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        width: double.infinity,
        child: AnimatedAlign(
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
                        child: _flipAnimation.value < 0.5
                            ? Image.asset(Image_assets.animation_cloud_front)
                            : Image.asset(Image_assets.animation_cloud_back),
                      );
                    }),
              ),
              // Animate position based on _positionAnimation
              AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: _showText ? 1 : 0,
                  child: Text(
                    "Remember My\nLove",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  )),

              AnimatedContainer(
                height: _animation2 ? 60.h : 0,
                width: _animation2 ? double.maxFinite : 0,
                duration: Duration(milliseconds: 2000),
                child: Column(children: [
                  Expanded(
                    child: GlassmorphicContainer(
                        width: _animation2 ? double.maxFinite : 0,
                        height: _animation2 ? double.maxFinite : 0,
                        borderRadius: 20,
                        border: 0,
                        blur: 10,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFffffff).withOpacity(0.1),
                              Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFffffff).withOpacity(0.5),
                            Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: Padding(
                          padding: kpaddingH4V2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Back!",
                                style: TextStyleConstants.displayMediumWhite(
                                    context),
                              ),
                              k2hSizedBox,
                              Text(
                                "Please Sign in to Continue your journey.",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              k1hSizedBox,
                              TextField(
                                decoration:
                                    InputDecoration(hintText: "Enter Email"),
                              ),
                              k1hSizedBox,
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    suffixIcon:
                                        Icon(Icons.visibility_off_outlined)),
                              ),
                              k1hSizedBox,
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (_) {}),
                                  k1wSizedBox,
                                  Text(
                                    "Remember me",
                                    style: TextStyleConstants.bodySmallWhite(
                                        context),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Forgot Password",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    color: Colors.white,
                                    height: 0.5,
                                  )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Text("Or",
                                        style:
                                            TextStyleConstants.bodyLargeWhite(
                                                context)),
                                  ),
                                  Expanded(
                                      child: Container(
                                    color: Colors.white,
                                    height: 0.5,
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomGlassButton(
                                    child: SvgPicture.asset(SvgAssets.google),
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
                              k1hSizedBox,
                              Text(
                                "Login with Touch ID",
                                style:
                                    TextStyleConstants.bodySmallWhite(context),
                              )
                            ],
                          ),
                        )),
                  ),
                  k1hSizedBox,
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              k2hSizedBox,
              SizedBox(
                height: kButtonHeight,
                child: GradientButton(
                  onPressed: () {},
                  gradients: const [Colors.purple, Colors.blue],
                  text: 'Sign In',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomGlassButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding; // Make padding optional
  final BorderRadius? borderRadius; // Make borderRadius optional

  CustomGlassButton({
    super.key,
    required this.child,
    this.padding, // Use this to declare as optional
    this.borderRadius, // Use this to declare as optional
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
