import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../screens/auth_screens/Splah_screen.dart';

class CustomRoundedGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback ontap;
  final double? height;
  final double? width;
  const CustomRoundedGlassButton(
      {super.key,
      required this.icon,
      required this.ontap,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: InkWell(
          onTap: () {
            ontap();
            print("widget ontap");
          },
          child: CustomGlassButton(
            padding: EdgeInsets.all(4.w),
            borderRadius: BorderRadius.circular(50),
            child: Icon(
              size: 3.h,
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
