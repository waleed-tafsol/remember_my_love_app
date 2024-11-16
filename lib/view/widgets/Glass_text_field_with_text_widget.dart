import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class GlassTextFieldWithTitle extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final String? Function(String?)? validator; // Add validator function

  const GlassTextFieldWithTitle({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.icon,
    this.validator, // Accept validator as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        k1hSizedBox,
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText ?? "",
            suffixIcon: Icon(icon),
          ),
          validator: validator, // Attach the validator here
        ),
      ],
    );
  }
}
