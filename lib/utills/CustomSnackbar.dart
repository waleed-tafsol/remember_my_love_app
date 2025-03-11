import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSnackbar {
  // Success Snackbar
  static void showSuccess(
    String title,
    String message, {
    OnTap? onTap, // Use the correct callback type here
  }) {
    Get.snackbar(
      title,
      message,
      maxWidth: 70.w,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      onTap: onTap,
    );
  }

  // Error Snackbar
  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      maxWidth: 70.w,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: const EdgeInsets.all(20),
      borderRadius: 20,
      duration: const Duration(seconds: 3),
    );
  }

  // Info Snackbar
  static void showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      maxWidth: 70.w,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      icon: const Icon(Icons.info, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  // Warning Snackbar
  static void showWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      maxWidth: 70.w,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      icon: const Icon(Icons.warning, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}
