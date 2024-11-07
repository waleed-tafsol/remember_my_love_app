import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar_screens/Home_screens/Memory_detail_screen.dart';
import 'package:remember_my_love_app/view/widgets/Custom_glass_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/assets.dart';
import '../../../auth_screens/Splash_screen.dart';

class MyMemoriesScreen extends StatelessWidget {
  const MyMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My Memories",
                style: TextStyleConstants.displayMediumWhite(context)),
            CustomGlassButton(
              padding: EdgeInsets.all(4.w),
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                size: 3.h,
                Icons.filter_alt_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        k1hSizedBox,
        Expanded(
          child: CustomGlassmorphicContainer(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(MemoryDetailScreen.routeName);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                      width: 9.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2), // Shadow color with opacity
                            spreadRadius: 4, // How far the shadow spreads
                            blurRadius: 6, // How soft or blurred the shadow is
                            offset: const Offset(
                                3, 3), // Position of the shadow (x, y)
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                              Image_assets.userImage,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
