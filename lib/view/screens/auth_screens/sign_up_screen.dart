import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../utills/ConvertDateTime.dart';
import 'package:remember_my_love_app/controllers/AuthController.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../constants/TextConstant.dart';
import '../../../../../constants/colors_constants.dart';
import '../../../../../constants/constants.dart';
import '../../../constants/assets.dart';
import '../../widgets/Custom_rounded_glass_button.dart';

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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CustomRoundedGlassButton(
                    icon: Icons.arrow_back_ios_new,
                    ontap: () {
                      Get.back();
                    }),
              ),
              Column(
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
                        fontFamily: 'Bookos',
                        color: Colors.white,
                        fontSize: 20.sp),
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
                              style: TextStyleConstants.displayMediumWhite(
                                  context),
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
                                  decoration: InputDecoration(
                                      hintText: "Enter User Name"),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r"\s")),
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
                                  "Date of Birth (DOB)",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      controller.buttonVisivility.value = false;
                                      BottomPicker.date(
                                        displayCloseIcon: true,
                                        closeIconColor: AppColors.kPrimaryColor,
                                        dismissable: false,
                                        displaySubmitButton: true,
                                       // gradientColors: [AppColors.kgradientPurple,AppColors.kSecondaryColor],
                                        backgroundColor: Colors.indigo,
                                        pickerTitle: Text(
                                          '',
                                          style: TextStyleConstants.bodyLargeWhite(context),
                                        ),
                                        buttonStyle: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50)),
                                        buttonWidth: 90.w,
                                        buttonContent: Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 1.h,
                                            ),
                                            child: Text(
                                              "Save",
                                              style: TextStyleConstants.bodyMediumWhite(context)
                                                  .copyWith(color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        dateOrder: DatePickerDateOrder.mdy,
                                        initialDateTime: controller.selectedDate.value,
                                        // minDateTime: controller.selectedDate.value
                                        //     .subtract(Duration(days: 1)),
                                        pickerTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.sp,
                                        ),
                                        onChange: (index) {
                                          controller.selectedDate.value = index;
                                        },
                                        onSubmit: (index) {
                                          print(index);
                                          // controller.updateSelectedDate(index);
                                          controller.buttonVisivility.value = true;
                                        },
                                        onCloseButtonPressed: () {
                                          controller.buttonVisivility.value = true;
                                          Get.back();
                                        },
                                      ).show(context);
                                    },
                                    child: CustomGlassmorphicContainer(
                                        borderRadius: 8,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 2.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              return Text(DateFormat('dd/MM/yyyy')
                                                  .format(controller.selectedDate.value));
                                            }),
                                            const Icon(
                                              Icons.event,
                                              color: AppColors.kIconColor,
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            k1hSizedBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Zip Code",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Zip Code is required";
                                    } /*else if (!GetUtils.isEmail(value)) {
                                      return 'Invalid Email';
                                    }*/
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter Zip Code",
                                  ),
                                  controller: controller.signupZipController,
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
                                              controller.passwordVisibility
                                                      .value =
                                                  !controller
                                                      .passwordVisibility.value;
                                            },
                                            icon: Icon(controller
                                                    .passwordVisibility.value
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
                                    obscureText: !controller
                                        .confirmPasswordVisibility.value,
                                    decoration: InputDecoration(
                                        hintText: "Confirm Your Password",
                                        errorText:
                                            controller.passconfrmErr.value,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              controller
                                                      .confirmPasswordVisibility
                                                      .value =
                                                  !controller
                                                      .confirmPasswordVisibility
                                                      .value;
                                            },
                                            icon: Icon(controller
                                                    .confirmPasswordVisibility
                                                    .value
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}
