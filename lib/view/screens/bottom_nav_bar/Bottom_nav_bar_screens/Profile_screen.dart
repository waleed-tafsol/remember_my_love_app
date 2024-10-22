import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/splash_screens/Splah_screen.dart';
import 'package:remember_my_love_app/view/screens/update_password_screen/update_password_screen.dart';
import 'package:remember_my_love_app/view/screens/upgrade_plan_screen.dart/upgrade_plan_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text("Profile",
                style: TextStyleConstants.headlineLargeWhite(context)),
          ],
        ),
        k1hSizedBox,
        CustomGlassmorphicContainer(
            height: 27.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      Image_assets.userImage,
                      height: 12.h,
                      width: 12.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                k2hSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Michael Jones",
                      style: TextStyleConstants.displayMediumWhiteBold(context),
                    ),
                    k3wSizedBox,
                    SvgPicture.asset(SvgAssets.edit)
                  ],
                ),
                k1hSizedBox,
                Text(
                  "Email:   johndoe@gmail.com",
                  style: TextStyleConstants.bodySmallWhite(context),
                ),
              ],
            )),
        CustomGlassmorphicContainer(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Storage",
                    style: TextStyleConstants.headlineLargeWhite(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "0.08 GB of 1 GB Used",
                    style: TextStyleConstants.bodyMediumWhite(context),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(UpgradePlanScreen.routeName);
                    },
                    child: Text(
                      "Upgrade to Premium",
                      style: TextStyleConstants.bodyMediumWhite(context)
                          .copyWith(
                              decoration: TextDecoration.underline,
                              color: Colors.amber),
                    ),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 5.h,
                lineWidth: 5.0,
                percent: 0.8,
                center: Text("80%"),
                progressColor: Colors.white,
              )
            ],
          ),
        ),
        k1hSizedBox,
        CustomGlassButton(
            onTap: () {
              Get.toNamed(UpdatePasswordScreen.routeName);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility_off,
                    color: Colors.white,
                  ),
                  k3wSizedBox,
                  Text(
                    "Change Password",
                    style: TextStyleConstants.bodyMediumWhite(context),
                  ),
                ],
              ),
            )),
        k2hSizedBox,
        CustomGlassButton(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              k3wSizedBox,
              Text(
                "Log Out",
                style: TextStyleConstants.bodyMediumWhite(context),
              ),
            ],
          ),
        )),
        k2hSizedBox,
        CustomGlassButton(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              k3wSizedBox,
              Text(
                "Delete Account",
                style: TextStyleConstants.bodyMediumWhite(context),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
