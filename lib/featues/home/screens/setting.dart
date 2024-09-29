import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/common/widgets/custom_button.dart';
import 'package:myapp/featues/home/controller/setting_controller.dart';

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
        body:GetBuilder<SettingController>(
          init: SettingController(),
          builder: (controller)=>
          Column(
            children: [
              Center(
                child: CustomButton(child: const Text("Change your image profile"), onTap: ()=>controller.dialogChoose()),
              ),
              controller.file!=null? Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image:FileImage(controller.file!))
                ),
              ):const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
