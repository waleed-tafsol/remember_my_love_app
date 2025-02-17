import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphicDailogBox extends StatelessWidget {
  const GlassMorphicDailogBox({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
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
                sigmaX: 13,
                sigmaY: 13,
                tileMode: TileMode.mirror), // Apply the blur effect
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}
