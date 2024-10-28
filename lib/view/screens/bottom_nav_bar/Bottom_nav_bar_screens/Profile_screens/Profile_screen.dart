import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Privacy_policy_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Terms_and_condition_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/update_password_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../splash_screens/Splah_screen.dart';
import '../Home_screens/Widgets/My_storage_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Profile",
              style: TextStyleConstants.headlineLargeWhite(context)),
          k2hSizedBox,
          CustomGlassmorphicContainer(
              // height: 27.h,
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
          const My_storage_widget(),
          k1hSizedBox,
          CustomGlassmorphicContainer(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(UpdatePasswordScreen.routeName);
                },
                child: Row(
                  children: [
                    const Icon(
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
          CustomGlassmorphicContainer(
            margin: const EdgeInsets.symmetric(vertical: 0),
            child: InkWell(
                onTap: () {
                  Get.offAllNamed(SplashScreen.routeName);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    k3wSizedBox,
                    Text(
                      "Log Out",
                      style: TextStyleConstants.bodyMediumWhite(context),
                    ),
                  ],
                )),
          ),
          k2hSizedBox,
          CustomGlassmorphicContainer(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(PrivacyPolicyScreen.routeName);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.white,
                    ),
                    k3wSizedBox,
                    Text(
                      "Privacy Policy",
                      style: TextStyleConstants.bodyMediumWhite(context),
                    ),
                  ],
                ),
              )),
          k2hSizedBox,
          CustomGlassmorphicContainer(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(TermsAndConditionScreen.routeName);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      color: Colors.white,
                    ),
                    k3wSizedBox,
                    Text(
                      "Terms and Conditions",
                      style: TextStyleConstants.bodyMediumWhite(context),
                    ),
                  ],
                ),
              )),
          k2hSizedBox,
          CustomGlassmorphicContainer(
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: InkWell(
                onTap: () {
                  // Get.toNamed(UpdatePasswordScreen.routeName);
                },
                child: Row(
                  children: [
                    const Icon(
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
              )),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
