import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as myuser;
import 'package:myapp/data/repositories/home_repo.dart';

class ProfileController extends GetxController
    with GetTickerProviderStateMixin {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TabController tabController;
  var user = myuser.User.empty().obs;
  SharedPredManager prefs = Get.find<SharedPredManager>();
  var listStatus = <Status>[].obs;
  var isEmptyList = false.obs;
  var isLoading = true.obs;
  var userId = ''.obs;

  //
  final HomeRepo homeRepo = Get.put(HomeRepo());

  getCurrentUser() {
    user.value = myuser.User.fromJson(jsonDecode(prefs.getString('userData') ?? ''));
  }

  getUserStatus(String userIdd) async {
    try {
      listStatus.value = await homeRepo.getStatusOfUser(userIdd);
      if (listStatus.isEmpty) {
        isEmptyList.value = true;
      } else {
        isEmptyList.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(Get.context!, "Error Fetch Status");
    } finally {
      update();
    }
  }

  getUserDetails() async {
    try {
      Map<String,dynamic> userData=await homeRepo.getUserDataById(userId.value);
      user.value=myuser.User.fromJson(userData);
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(
          Get.context!, "Error Fetch Data Of This User");
    } finally {
      update();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    if (userId.value.isNotEmpty) {
      await getUserDetails();
      await getUserStatus(userId.value);
    } else {
      await getCurrentUser();
      await getUserStatus(user.value.id);
    }
  }
}
