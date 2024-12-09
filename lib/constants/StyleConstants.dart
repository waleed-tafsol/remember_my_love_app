import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors_constants.dart';

class StylesConstants {
  static final ButtonStyle elevated_b_redBack_whiteFore =
      ElevatedButton.styleFrom(
    textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    backgroundColor: AppColors.kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
  );
  static final ButtonStyle elevated_b_purplebackground_whiteforeground =
      ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
