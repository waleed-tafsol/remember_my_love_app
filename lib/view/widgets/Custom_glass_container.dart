import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constants.dart';

class CustomGlassmorphicContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? blur;
  final LinearGradient? linearGradient;
  final LinearGradient? borderGradient;
  final Widget child;

  const CustomGlassmorphicContainer({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.blur,
    this.linearGradient,
    this.borderGradient,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: margin ?? EdgeInsets.symmetric(vertical: 1.h),
        child: GlassmorphicContainer(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: borderRadius ?? 20,
          border: 0,
          blur: 10,
          linearGradient: linearGradient ??
              LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.1),
                    Color(0xFFFFFFFF).withOpacity(0.05),
                  ],
                  stops: [
                    0.1,
                    1,
                  ]),
          borderGradient: borderGradient ??
              LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.5),
                  Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
          child: Padding(
            padding: padding ?? kpaddingH4V2,
            child: child,
          ),
        ),
      ),
    );
  }
}
