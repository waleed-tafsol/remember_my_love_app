import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/colors_constants.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/sign_up_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UploadMemoryScreen extends StatelessWidget {
  const UploadMemoryScreen({super.key});
  static const routeName = "UploadMemoryScreen";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Upload Memory",
          style: TextStyleConstants.displaySmallWhiteBold(context),
        ),
        Text(
          "It is a long established fact that a reader will "
          "be distracted by the readable content"
          " of a page when looking at its layout.",
          textAlign: TextAlign.center,
          style: TextStyleConstants.bodyLargeWhite(context),
        ),
        CustomGlassmorphicContainer(
            height: 20.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    size: 8.h,
                    Icons.image_outlined,
                    color: AppColors.kIconColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Select Image or Video",
                    style: TextStyleConstants.bodyLargeWhite(context),
                  )
                ],
              ),
            )),
        Row(
          children: [
            Expanded(child: Divider()),
            k1wSizedBox,
            Text("Or"),
            k1wSizedBox,
            Expanded(child: Divider())
          ],
        ),
        CustomGlassmorphicContainer(
            child: Center(
          child: Text(
            "Take a Photo/Video",
            style: TextStyleConstants.bodyLargeWhite(context),
          ),
        )),
        SizedBox(
          height: 30.h,
        ),
        GradientButton(
            onPressed: () {},
            text: "Continue",
            gradients: [Colors.purple, Colors.blue])
      ],
    );
  }
}
