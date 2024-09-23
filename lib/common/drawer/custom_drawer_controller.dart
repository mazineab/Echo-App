import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_item.dart';
import 'package:myapp/common/drawer/drawer_item.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';

import '../../routes/routes_names.dart';

class CustomDrawerController extends GetxController {
  var drawerItem = DrawerItem.home.obs;
  var listItems = <CustomItem>[].obs;

  setSelectedScreen(DrawerItem item) {
    if (drawerItem.value != item) {
      drawerItem.value = item;
    }
  }

  setSelectedHome(){
    setSelectedScreen(DrawerItem.home);
    Get.offNamed(RoutesNames.home);
  }

  buildItems() {
    listItems.assignAll([
      CustomItem(
        title: "Home",
        iconData: Icons.home,
        onTap: () {
          setSelectedScreen(DrawerItem.home);
          Get.offNamed(RoutesNames.home);
        },
        itemDrawer: DrawerItem.home,
      ),
      CustomItem(
          title: "Profile",
          iconData: Icons.person,
          onTap: () {
            setSelectedScreen(DrawerItem.profile);
            Get.toNamed(RoutesNames.profile);
          },
          itemDrawer: DrawerItem.profile),
      CustomItem(
          title: "Setting",
          iconData: Icons.settings,
          onTap: () {
            setSelectedScreen(DrawerItem.settings);
            Get.offNamed(RoutesNames.setting);
          },
          itemDrawer: DrawerItem.settings),
      CustomItem(
          title: "about us",
          iconData: Icons.info,
          onTap: () {
            setSelectedScreen(DrawerItem.aboutUs);
            Get.offNamed(RoutesNames.addStatus);
          },
          itemDrawer: DrawerItem.aboutUs),
      CustomItem(
          title: "logout",
          iconData: Icons.logout,
          onTap: () {
            Get.find<HomeController>().logout();
            setSelectedScreen(DrawerItem.logout);
            Get.offNamed(RoutesNames.login);
          },
          itemDrawer: DrawerItem.logout)
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    buildItems();
  }
}
