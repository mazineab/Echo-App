import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomSnackbar {
  static void showSuccessSnackbar(BuildContext context, String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
    );
  }

  static void showErrorSnackbar(BuildContext context,String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.error, color: Colors.white),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
    );
  }

}
