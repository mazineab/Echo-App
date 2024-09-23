import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final controller = Get.find<CustomDrawerController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        buildHeader(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: const Divider(
            height: 1,
            color: Color.fromARGB(65, 0, 0, 0),
          ),
        ),
        Obx(()=>
          Expanded(
              child: ListView(
            children: controller.listItems,
          )),
        )
      ],
    ));
  }

  Widget buildHeader({bool isDrawer=true}) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const SizedBox(
          width: 110,
          height: 110,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.jpeg"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        isDrawer?Column(
          children: [
            Text(
          Get.find<HomeController>().fullName.value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
          ],
        )
        :const SizedBox()
        
      ],
    );
  }
}
