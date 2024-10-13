import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/common/drawer/custom_drawer_controller.dart';
import 'package:myapp/core/services/image_picker_service.dart';
import 'package:myapp/core/services/permission_service.dart';
import 'package:myapp/data/models/user.dart' as my_user;
import 'package:myapp/featues/home/controller/current_user_controller.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import 'package:myapp/routes/routes_names.dart';
import 'package:path/path.dart' as pth;

import '../../../core/utils/localStorage/shared_pref_manager.dart';
import '../../../data/models/enums.dart';

class SettingController extends GetxController {
  final currentController = Get.find<CurrentUserController>();
  final homeController = Get.find<HomeController>();
  final drawerController = Get.find<CustomDrawerController>();
  final ImagePickerService _imagePickerService = Get.put(ImagePickerService());
  final PermissionService _permissionService = Get.put(PermissionService());
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final SharedPredManager prefs = Get.find<SharedPredManager>();
  final FirebaseStorage firebaseStorage =
      FirebaseStorage.instanceFor(bucket: "gs://fir-appactions.appspot.com");

  //controllers
  final TextEditingController textControllerName = TextEditingController();
  final TextEditingController textControllerLastName = TextEditingController();
  final TextEditingController textControllerEmail = TextEditingController();
  final TextEditingController textControllerPhone = TextEditingController();

  File? file;
  var url = ''.obs;
  var user = my_user.User.empty().obs;
  var group = ''.obs;
  var isChange=false.obs;
  var loading=false.obs;

  @override
  onInit() {
    super.onInit();
    getCurrentUser();
    group.value = user.value.sexe.name == "male" ? "Male" : "Female";
  }

  getCurrentUser() {
    user.value = Get.find<CurrentUserController>().me.value;
  }

  Future<void> saveChanges()async{
    loading.value=true;
    user.value.firstName=textControllerName.text;
    user.value.lastName=textControllerLastName.text;
    user.value.email=textControllerEmail.text;
    user.value.phoneNumber=textControllerPhone.text;
    user.value.sexe=group.value=='Female'?Sexe.female:Sexe.male;
    try{
      await _firebaseFirestore.collection('users').doc(user.value.uId).update(user.value.toJson());
      CustomSnackbar.showSuccessSnackbar(Get.context!,"Succes Updating you data");
    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!,"Error updating your data try again please");
    }finally{
      loading.value=false;
    }
  }

  saveUserData(my_user.User updatedUser) async {
    try {
      await prefs.saveString('userData', jsonEncode(updatedUser.toJson()));
      currentController.getUserData();
      homeController.getUserData();
      drawerController.getUserData();
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> chooseFromGallery() async {
    bool permissionGranted = await _permissionService.requestGallery();
    if (!permissionGranted) {
      Get.snackbar(
          "Permission Denied", "You need to grant the required permissions.");
      return;
    }

    var image = await _imagePickerService.chooseImageFromGallery();
    if (image != null) {
      try {
        var imageName = pth.basename(image.path);
        var refStorage = firebaseStorage.ref("profiles/$imageName");
        await refStorage.putFile(image);
        url.value = await refStorage.getDownloadURL();
        user.value.imageUrl = url.value;
        await saveUserData(user.value);
        QuerySnapshot QrSnap = await _firebaseFirestore
            .collection('users')
            .where('id', isEqualTo: user.value.id)
            .get();
        await QrSnap.docs.first.reference.update(user.value.toJson());
        Get.snackbar("Upload Successful", "Image uploaded successfully!");
        update();
      } catch (e) {
        Get.snackbar("Upload Failed", "Failed to upload image: $e");
        Exception(e);
      }
    }
    
  }

  Future<void> chooseFromCamera() async {
    bool permissionGranted = await _permissionService.requestCamera();
    if (!permissionGranted) {
      Get.snackbar(
          "Permission Denied", "You need to grant the required permissions.");
      return;
    }
    try {
      var image = await _imagePickerService.chooseImageFromCamera();
      if (image != null) {
        var imageName = pth.basename(image.path);
        var refStorage = firebaseStorage.ref("profiles/$imageName");
        await refStorage.putFile(image);
        url.value = await refStorage.getDownloadURL();
      }
    } catch (e) {
      Exception(e);
    }
    update();
  }

  Future<void> dialogChoose() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose image"),
          actions: [
            TextButton(
              onPressed: () {
                chooseFromGallery();
                Get.back();
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () {
                chooseFromCamera();
                Get.back();
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }



  //setting navigation

  goPersonalInfo(){
    Get.toNamed(RoutesNames.personalInfo);
  }
}


