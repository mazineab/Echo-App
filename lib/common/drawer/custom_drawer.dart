import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';

import '../widgets/image_widget.dart';

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
    return Obx(()=>
      Column(
        children: [
          isDrawer?const SizedBox(height: 50):const SizedBox(),
          SizedBox(
            width: 100,
            height: 100,
            child: ImageWidget(imageUrl:controller.user.value.imageUrl??'',userName:controller.user.value.getFullName()),
          ),
          const SizedBox(
            height: 10,
          ),
          isDrawer?Column(
            children: [
              Text(
                controller.user.value.getFullName(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
            ],
          )
          :const SizedBox()

        ],
      ),
    );
  }
}
