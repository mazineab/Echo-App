import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/common/widgets/image_widget.dart';
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
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
                    height: 100,
                    width: 100,
                  child: ImageWidget(imageUrl: controller.user.value.imageUrl,userName: controller.user.value.getFullName()),
                ),
                const SizedBox(height: 5),
                editImage(controller.chooseFromGallery)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget editImage(onTap){
    return GestureDetector(
      onTap: ()async=>await onTap(),
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.8),
            borderRadius: BorderRadius.circular(50)
        ),
        child:const Text("Edit image",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
