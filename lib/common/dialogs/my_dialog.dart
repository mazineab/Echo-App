import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog {
  Widget dialogExist() {
    return showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: const Text("Info"),
                content: const Text("do you want to exist this app"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("No")),
                  TextButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text("Yes")),
                ],
              );
            }) as Widget;
  }
}
