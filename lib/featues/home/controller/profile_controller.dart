import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as myuser;

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

  getCurrentUser() {
    user.value =
        myuser.User.fromJson(jsonDecode(prefs.getString('userData') ?? ''));
  }

  getUserStatus(String userIdd) async {
    try {
      CollectionReference docRef = firestore.collection('status');
      QuerySnapshot querySnapshot =
          await docRef.where('userId', isEqualTo: userIdd).get();
      for (var i in querySnapshot.docs) {
        listStatus.add(Status.fromJson(i.data() as Map<String, dynamic>));
      }
      if (listStatus.isEmpty) {
        isEmptyList.value = true;
      } else {
        isEmptyList.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      Exception(e);
    }
    update();
  }

  getUserDetails() async {
    try {
      CollectionReference docRef = firestore.collection('users');
      QuerySnapshot querySnapshot =
          await docRef.where('id', isEqualTo: userId.value).get();
      DocumentSnapshot docSnapshot = querySnapshot.docs[0];

      if (docSnapshot.exists) {
        user.value =
            myuser.User.fromJson(docSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Exception(e);
    }
    update();
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
