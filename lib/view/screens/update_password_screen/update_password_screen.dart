import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/Custom_rounded_glass_button.dart';
import 'package:remember_my_love_app/view/widgets/Glass_text_field_with_text_widget.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/gradient_button.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});
  static const routeName = 'UpdatePasswordScreen';

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
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlassTextFieldWithTitle(
              title: "Current Password",
              hintText: "Enter current password",
            ),
            k2hSizedBox,
            const GlassTextFieldWithTitle(
              title: "New Password",
              hintText: "Enter new password",
            ),
            k2hSizedBox,
            const GlassTextFieldWithTitle(
              title: "Confirm Password",
              hintText: "Enter confirm password",
            ),
            k2hSizedBox,
          ],
        )),
        const Spacer(),
        GradientButton(
            onPressed: () {},
            text: "Update",
            gradients: const [Colors.purple, Colors.blue])
      ],
    ));
  }
}
