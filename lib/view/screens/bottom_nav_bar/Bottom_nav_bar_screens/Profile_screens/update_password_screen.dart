import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/Update_Pass_controller.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/Glass_text_field_with_text_widget.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';

class UpdatePasswordScreen extends GetView<UpdatePassController> {
  const UpdatePasswordScreen({super.key});
  static const routeName = 'UpdatePasswordScreen';

  @override
  Widget build(BuildContext context) {
    final UpdatePassController updatePassController = Get.find();
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
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Current Password")),
            k1hSizedBox,
            Obx(() {
              return TextField(
                onChanged: (value) {
                  updatePassController.validateForm();
                },
                controller: updatePassController.current_pass_controller,
                obscureText:
                    !updatePassController.curr_passwordVisibility.value,
                decoration: InputDecoration(
                    hintText: "Enter current Password",
                    errorText: updatePassController.curr_passwordError.value,
                    suffixIcon: IconButton(
                        onPressed: () {
                          updatePassController.curr_passwordVisibility.value =
                              !updatePassController
                                  .curr_passwordVisibility.value;
                        },
                        icon: Icon(
                            updatePassController.curr_passwordVisibility.value
                                ? Icons.visibility
                                : Icons.visibility_off))),
              );
            }),
            k2hSizedBox,
            Align(alignment: Alignment.centerLeft, child: Text("New Password")),
            k1hSizedBox,
            Obx(() {
              return TextField(
                onChanged: (value) {
                  updatePassController.validateForm();
                },
                controller: updatePassController.new_pass_controller,
                obscureText: !updatePassController.new_passwordVisibility.value,
                decoration: InputDecoration(
                    hintText: "Enter new Password",
                    errorText: updatePassController.newpasswordError.value,
                    suffixIcon: IconButton(
                        onPressed: () {
                          updatePassController.new_passwordVisibility.value =
                              !updatePassController
                                  .new_passwordVisibility.value;
                        },
                        icon: Icon(
                            updatePassController.new_passwordVisibility.value
                                ? Icons.visibility
                                : Icons.visibility_off))),
              );
            }),
            k2hSizedBox,
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password")),
            k1hSizedBox,
            Obx(() {
              return TextField(
                onChanged: (value) {
                  updatePassController.validateForm();
                },
                controller: updatePassController.confirm_pass_controller,
                obscureText:
                    !updatePassController.confirm_passwordVisibility.value,
                decoration: InputDecoration(
                    hintText: "Enter Password",
                    errorText: updatePassController.cnfrm_passwordError.value,
                    suffixIcon: IconButton(
                        onPressed: () {
                          updatePassController
                                  .confirm_passwordVisibility.value =
                              !updatePassController
                                  .confirm_passwordVisibility.value;
                        },
                        icon: Icon(updatePassController
                                .confirm_passwordVisibility.value
                            ? Icons.visibility
                            : Icons.visibility_off))),
              );
            }),
            k2hSizedBox,
          ],
        )),
        const Spacer(),
        GradientButton(
            onPressed: () {
              updatePassController.ChangePass();
            },
            text: "Update",
            gradients: const [Colors.purple, Colors.blue])
      ],
    ));
  }
}
