import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/common/drawer/drawer_item.dart';

// ignore: must_be_immutable
class CustomItem extends StatelessWidget {
  String title;
  IconData iconData;
  // bool isSelected;
  DrawerItem itemDrawer;
  VoidCallback onTap;
  CustomItem(
      {super.key,
      required this.title,
      required this.iconData,
      // required this.isSelected,
      required this.itemDrawer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<CustomDrawerController>();
      bool isSelected = controller.drawerItem.value == itemDrawer;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          onTap: onTap,
          leading: Icon(iconData,
              color: isSelected
                  ? const Color.fromARGB(228, 114, 206, 249)
                  :  Colors.grey[400]),
          title: Text(title,
              style: TextStyle(
                  color: isSelected
                      ? const Color.fromARGB(228, 114, 206, 249)
                      : Colors.grey[400])),
          //non selected color #9e9ea1
          //selected color #37383c
        ),
      );
    });
  }
}
