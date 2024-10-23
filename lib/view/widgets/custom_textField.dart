import 'package:flutter/material.dart';
import 'package:remember_my_love_app/constants/TextConstant.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final Icon? suffixIcon;
  const CustomTextfield({super.key, required this.hintText, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleConstants.bodySmallWhite(context),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white, // Set the border color to white
              width: 0.4),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white, // White border when TextField is not focused
              width: 0.4),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white, // White border when TextField is focused
              width: 0.4),
        ),
      ),
    );
  }
}
