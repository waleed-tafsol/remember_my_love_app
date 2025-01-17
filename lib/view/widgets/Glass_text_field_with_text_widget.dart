import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class GlassTextFieldWithTitle extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Widget? prefixWidget;
  final TextInputType? keyboardType;
  final bool? enabled;
  final String? Function(String?)? validator; // Add validator function

  const GlassTextFieldWithTitle({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.prefixWidget,
    this.suffixIcon,
    this.enabled,
    this.validator,
    this.obscureText,
    this.keyboardType, // Accept validator as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        k1hSizedBox,
        TextFormField(
          enabled: enabled,

          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixWidget,
            hintText: hintText ?? "",
            suffixIcon: suffixIcon,
          ),
          validator: validator, // Attach the validator here
        ),
      ],
    );
  }
}
