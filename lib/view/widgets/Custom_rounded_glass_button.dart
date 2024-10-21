import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../screens/splash_screens/Splah_screen.dart';

class CustomRoundedGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback ontap;
  const CustomRoundedGlassButton(
      {super.key, required this.icon, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap;
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
    );
  }
}
