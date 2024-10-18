import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../constants/constants.dart';

class CustomGlassmorphicContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;
  final double? blur;
  final LinearGradient? linearGradient;
  final LinearGradient? borderGradient;
  final Widget child;

  const CustomGlassmorphicContainer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.blur,
    this.linearGradient,
    this.borderGradient,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
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
        padding: kpaddingH4V2,
        child: child,
      ),
    );
  }
}
