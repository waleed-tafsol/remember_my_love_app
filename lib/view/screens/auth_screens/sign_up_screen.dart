import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/TextConstant.dart';
import '../../../constants/assets.dart';
import '../../../constants/constants.dart';

class SignUpScreen extends GetView<AuthController> {
  SignUpScreen({super.key});
  static const routeName = "SignUpScreen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // AuthController controller = Get.put(AuthController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Column(
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
                  child: Form(
                    key: _formKey,
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
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Name",
                              ),
                              controller: controller.nameController,
                            )
                          ],
                        ),
                        k1hSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "UserName",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "UserName is required";
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(hintText: "Enter User Name"),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                              ],
                              controller: controller.userNameController,
                            )
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
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email is required";
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Email",
                              ),
                              controller: controller.signupemailController,
                            )
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
                            Obx(() {
                              return TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is required";
                                  }
                                  return null;
                                },
                                controller: controller.signupPassController,
                                obscureText:
                                    !controller.passwordVisibility.value,
                                decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.passwordVisibility.value =
                                              !controller
                                                  .passwordVisibility.value;
                                        },
                                        icon: Icon(
                                            controller.passwordVisibility.value
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
                              return TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is required";
                                  } else if (controller
                                          .signupPassController.text
                                          .trim() !=
                                      value.trim()) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                                controller: controller.passCnfirmController,
                                obscureText:
                                    !controller.confirmPasswordVisibility.value,
                                decoration: InputDecoration(
                                    hintText: "Confirm Your Password",
                                    errorText: controller.passconfrmErr.value,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.confirmPasswordVisibility
                                                  .value =
                                              !controller
                                                  .confirmPasswordVisibility
                                                  .value;
                                        },
                                        icon: Icon(controller
                                                .confirmPasswordVisibility.value
                                            ? Icons.visibility
                                            : Icons.visibility_off))),
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  )),
              // const Spacer(),
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
                    if (_formKey.currentState!.validate()) {
                      controller.signup();
                    }
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
        ),
      ),
    );
  }
}
