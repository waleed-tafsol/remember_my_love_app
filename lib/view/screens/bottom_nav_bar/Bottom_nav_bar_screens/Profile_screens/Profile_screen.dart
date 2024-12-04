import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/assets.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/controllers/HomeScreenController.dart';
import 'package:remember_my_love_app/services/Auth_services.dart';
import 'package:remember_my_love_app/services/Auth_token_services.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Privacy_policy_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/Terms_and_condition_screen.dart';
import 'package:remember_my_love_app/view/screens/auth_screens/Splash_screen.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Profile_screens/update_password_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Home_screens/Widgets/My_storage_widget.dart';

class ProfileScreen extends GetView<HomeScreenController> {
  const ProfileScreen({super.key});

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 2, 255, 242).withOpacity(0.3),
                  const Color.fromARGB(255, 255, 0, 238).withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 0,
                    sigmaY: 13,
                    tileMode: TileMode.mirror), // Apply the blur effect
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      k2hSizedBox,
                      Text(
                        'Are you sure you want to delete your account? This action is irreversible.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      k1hSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              authService.deleteAccount(
                                  controller.user.value?.sId ?? "");
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Profile",
              style: TextStyleConstants.displayMediumWhite(context)),
          k2hSizedBox,
          CustomGlassmorphicContainer(
              // height: 27.h,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 6.2.h,
                backgroundColor: Colors.white,
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
                  Obx(() {
                    return Text(
                      controller.user.value?.name ?? "------ ----",
                      style: TextStyleConstants.displayMediumWhiteBold(context),
                    );
                  }),
                  k3wSizedBox,
                  SvgPicture.asset(SvgAssets.edit)
                ],
              ),
              k1hSizedBox,
              Text(
                "Email:   ${controller.user.value?.email ?? "xyz@mail.com"}",
                style: TextStyleConstants.bodyMediumWhite(context),
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
                  _showDeleteConfirmationDialog(context);
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
          k2hSizedBox,
          CustomGlassmorphicContainer(
            margin: const EdgeInsets.symmetric(vertical: 0),
            child: InkWell(
                onTap: () {
                   authService.logout();
                  //TokenService().deleteToken();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    k3wSizedBox,
                    Text(
                      "Logout",
                      style: TextStyleConstants.bodyMediumWhite(context),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
