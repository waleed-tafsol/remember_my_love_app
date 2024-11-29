import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/UpdatePasswordController.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/Glass_text_field_with_text_widget.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';

class UpdatePasswordScreen extends GetView<UpdatePasswordController> {
  UpdatePasswordScreen({super.key});
  static const routeName = 'UpdatePasswordScreen';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        Row(
          children: [
            CustomRoundedGlassButton(
              icon: Icons.arrow_back_ios_new,
              ontap: () {
                Get.back();
              },
            ),
            k3wSizedBox,
            Text("Update Password",
                style: TextStyleConstants.headlineLargeWhite(context)),
          ],
        ),
        k1hSizedBox,
        CustomGlassmorphicContainer(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return GlassTextFieldWithTitle(
                  controller: controller.currentpasswordController,
                  title: "Current Password",
                  hintText: "Enter current password",
                  obscureText: !controller.currentpasswordVisibility.value,
                  icon: IconButton(
                      onPressed: () {
                        controller.currentpasswordVisibility.value =
                            !controller.currentpasswordVisibility.value;
                      },
                      icon: Icon(controller.currentpasswordVisibility.value
                          ? Icons.visibility
                          : Icons.visibility_off_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    return null;
                  },
                );
              }),
              k2hSizedBox,
              Obx(() {
                return GlassTextFieldWithTitle(
                  controller: controller.newpasswordController,
                  title: "New Password",
                  hintText: "Enter new password",
                  obscureText: !controller.newpasswordVisibility.value,
                  icon: IconButton(
                      onPressed: () {
                        controller.newpasswordVisibility.value =
                            !controller.newpasswordVisibility.value;
                      },
                      icon: Icon(controller.newpasswordVisibility.value
                          ? Icons.visibility
                          : Icons.visibility_off_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new password";
                    }
                    return null;
                  },
                );
              }),
              k2hSizedBox,
              Obx(() {
                return GlassTextFieldWithTitle(
                  controller: controller.confirmpasswordController,
                  title: "Confirm Password",
                  hintText: "Enter confirm password",
                  obscureText: !controller.confirmpasswordVisibility.value,
                  icon: IconButton(
                      onPressed: () {
                        controller.confirmpasswordVisibility.value =
                            !controller.confirmpasswordVisibility.value;
                      },
                      icon: Icon(controller.confirmpasswordVisibility.value
                          ? Icons.visibility
                          : Icons.visibility_off_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password";
                    } else if (value != controller.newpasswordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                );
              }),
              k2hSizedBox,
            ],
          ),
        )),
        const Spacer(),
        Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : GradientButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.updatePassword();
                    }
                  },
                  text: "Update",
                  gradients: const [Colors.purple, Colors.blue]);
        })
      ],
    ));
  }
}
