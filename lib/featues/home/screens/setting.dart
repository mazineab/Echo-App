import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.find<CustomDrawerController>().setSelectedHome();
      },
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomDrawer(),
        body:const Center(
          child: Text("Setting"),
        ),
      ),
    );
  }
}
