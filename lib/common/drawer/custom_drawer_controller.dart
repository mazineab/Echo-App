import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/drawer/custom_item.dart';
import 'package:myapp/common/drawer/drawer_item.dart';
import 'package:myapp/data/models/user.dart' as my_user;
import 'package:myapp/featues/home/controller/current_user_controller.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';

import '../../core/utils/localStorage/shared_pref_manager.dart';
import '../../routes/routes_names.dart';

class CustomDrawerController extends GetxController {
  final SharedPredManager prefs = Get.find<SharedPredManager>();
  final currentUserController=Get.find<CurrentUserController>();
  var drawerItem = DrawerItem.home.obs;
  var listItems = <CustomItem>[].obs;
  var user = my_user.User.empty().obs;

  setSelectedScreen(DrawerItem item) {
    if (drawerItem.value != item) {
      drawerItem.value = item;
    }
  }

  getUserData() {
    user.value=currentUserController.me.value;
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
            Get.toNamed(RoutesNames.setting);
          },
          itemDrawer: DrawerItem.settings),
      CustomItem(
          title: "about us",
          iconData: Icons.info,
          onTap: () {
            setSelectedScreen(DrawerItem.aboutUs);
            Get.toNamed(RoutesNames.addStatus);
          },
          itemDrawer: DrawerItem.aboutUs),
      CustomItem(
          title: "logout",
          iconData: Icons.logout,
          onTap: () async{
            await Get.find<CurrentUserController>().logout();
            Get.delete<CustomDrawerController>();
            Get.offAllNamed(RoutesNames.login);
          },
          itemDrawer: DrawerItem.logout)
    ]);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserData();
    await buildItems();
  }
}
