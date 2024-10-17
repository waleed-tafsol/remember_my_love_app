import 'package:flutter/material.dart';

class TextStyleConstants {
  static TextStyle displayMediumWhiteBold(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle displayMediumWhite(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
          color: Colors.white,
        );
  }

  static TextStyle bodyMediumWhite(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        );
  }

  static TextStyle bodySmallWhite(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
        );
  }

  static TextStyle bodyLargeWhite(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.white,
        );
  }

  // Add more text styles as needed
}
