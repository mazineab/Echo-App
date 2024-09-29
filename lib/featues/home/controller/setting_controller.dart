import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/services/image_picker_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingController extends GetxController {
  final ImagePickerService _imagePickerService = Get.put(ImagePickerService());

  File? file;

  Future<void> chooseFromGallery() async {
    // Ensure permissions are granted
    bool permissionGranted = await requestPermissions();
    if (!permissionGranted) {
      Get.snackbar("Permission Denied", "You need to grant the required permissions.");
      return;
    }

    // Choose image from gallery
    var image = await _imagePickerService.chooseImageFromGallery();
    if (image != null) {
      file = image;
      update();  // Notify UI of the updated file
    }
  }

  Future<void> chooseFromCamera() async {
    // Ensure permissions are granted
    bool permissionGranted = await requestPermissions();
    if (!permissionGranted) {
      Get.snackbar("Permission Denied", "You need to grant the required permissions.");
      return;
    }

    // Choose image from camera
    var image = await _imagePickerService.chooseImageFromCamera();
    if (image != null) {
      file = image;
      update();  // Notify UI of the updated file
    }
  }

  Future<void> dialogChoose() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose image"),
          actions: [
            TextButton(
              onPressed: () {
                chooseFromGallery();
                Get.back();  // Close the dialog
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () {
                chooseFromCamera();
                Get.back();  // Close the dialog
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> requestPermissions() async {
    // Request camera and storage permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      // Handle if permission is permanently denied
      if (statuses[Permission.camera]?.isPermanentlyDenied == true ||
          statuses[Permission.storage]?.isPermanentlyDenied == true) {
        await Get.defaultDialog(
          title: "Permission required",
          content: const Text("You need to grant the required permissions in settings."),
          confirm: TextButton(
            onPressed: () {
              openAppSettings(); // Redirect to app settings
              Get.back();
            },
            child: const Text("Open Settings"),
          ),
        );
        return false;
      }
    }

    return allGranted;
  }
}
