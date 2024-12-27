import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Make sure this package is added in your pubspec.yaml
import 'package:intl_phone_field/phone_number.dart';
import 'package:responsive_sizer/responsive_sizer.dart'; // For screen size responsiveness
import '../../constants/colors_constants.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(PhoneNumber?)?
      validator; // Update to accept PhoneNumber?
  final Function(String)? onChanged;
  final String initialCountryCode;
  final String languageCode;
  final bool disableLengthCheck;
  final bool showDropdownIcon;

  const PhoneNumberField({
    Key? key,
    this.controller,
    this.validator,
    this.onChanged,
    this.initialCountryCode = 'BH',
    this.languageCode = 'en',
    this.disableLengthCheck = true,
    this.showDropdownIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      disableLengthCheck: disableLengthCheck,
      showDropdownIcon: showDropdownIcon,
      validator: validator, // Pass the validator here
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          fontSize: 15.sp,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 1.h),
        filled: true,
        hintText: "Enter Phone Number",
        focusedBorder: InputBorder.none,
        fillColor: AppColors.kTextfieldColor,
      ),
      initialCountryCode: initialCountryCode,
      languageCode: languageCode,
      onChanged: (phone) {
        if (onChanged != null) {
          onChanged!(
              phone.completeNumber); // This will return the full phone number
        }
      },
      onCountryChanged: (country) {},
    );
  }
}
