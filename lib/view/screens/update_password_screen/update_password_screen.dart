import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/screens/splash_screens/Splah_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:remember_my_love_app/view/widgets/custom_scaffold.dart';
import 'package:remember_my_love_app/view/widgets/custom_textField.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            CustomGlassButton(
              padding: EdgeInsets.all(4.w),
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                size: 3.h,
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            k3wSizedBox,
            Text("Update Password",
                style: TextStyleConstants.headlineLargeWhite(context)),
          ],
        ),
        k1hSizedBox,
        CustomGlassmorphicContainer(
            height: 37.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Password",
                  style: TextStyleConstants.bodyMediumWhite(context),
                ),
                k1hSizedBox,
                const CustomTextfield(
                  hintText: 'Enter current password',
                  suffixIcon: Icon(
                    Icons.visibility_off_rounded,
                    size: 16,
                  ),
                ),
                k2hSizedBox,
                Text(
                  "New Password",
                  style: TextStyleConstants.bodyMediumWhite(context),
                ),
                k1hSizedBox,
                const CustomTextfield(
                  hintText: 'Enter new password',
                  suffixIcon: Icon(
                    Icons.visibility_off_rounded,
                    size: 16,
                  ),
                ),
                k2hSizedBox,
                Text(
                  "Confirm Password",
                  style: TextStyleConstants.bodyMediumWhite(context),
                ),
                k1hSizedBox,
                const CustomTextfield(
                  hintText: 'Enter confirm password',
                  suffixIcon: Icon(
                    Icons.visibility_off_rounded,
                    size: 16,
                  ),
                )
              ],
            )),
        const Spacer(),
        GradientButton(
            onPressed: () {},
            text: "Update",
            gradients: [Colors.purple, Colors.blue])
      ],
    ));
  }
}
