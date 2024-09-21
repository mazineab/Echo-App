import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';

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

  Widget buildHeader() {
    return const Column(
      children: [
        SizedBox(height: 50),
        SizedBox(
          width: 110,
          height: 110,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.jpeg"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Mazine Abj",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
