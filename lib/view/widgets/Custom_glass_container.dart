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
    super.key,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.blur,
    this.linearGradient,
    this.borderGradient,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: margin ?? EdgeInsets.symmetric(vertical: 1.h),
        child: GlassmorphicContainer(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: borderRadius ?? 20,
          border: 1.5,
          blur: blur ?? 10,
          linearGradient: linearGradient ??
              LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 2, 255, 242).withOpacity(0.3),
                    const Color.fromARGB(255, 255, 0, 238).withOpacity(0.3),
                  ],
                  stops: const [
                    0.1,
                    1,
                  ]),
          borderGradient: borderGradient ??
              LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 130, 236, 231).withOpacity(0.4),
                  const Color.fromARGB(255, 252, 101, 242).withOpacity(0.4),
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
