import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';
import 'package:remember_my_love_app/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/assets.dart';
import '../../../splash_screens/Splah_screen.dart';

class MyMemoriesScreen extends StatelessWidget {
  const MyMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My Memories",
                  style: TextStyleConstants.headlineLargeWhite(context)),
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
          GridView.builder(
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
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: 9.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage(
                        Image_assets.userImage,
                      ),
                      fit: BoxFit.cover),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
