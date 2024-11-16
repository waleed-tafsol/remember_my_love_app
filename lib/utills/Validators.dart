String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  // Regular expression for validating email format
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null; // Return null if the email is valid
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  // Regular expression for validating phone number format
  final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Enter a valid phone number';
  }
  return null; // Return null if the phone number is valid
}
