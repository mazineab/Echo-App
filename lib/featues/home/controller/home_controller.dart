import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as MyUser;
import 'package:myapp/routes/routes_names.dart';

import '../../../core/utils/localStorage/shared_pref_manager.dart';

class HomeController extends GetxController {
  final fireabseFireStore = FirebaseFirestore.instance;
  var listUsers = <MyUser.User>[].obs;
  final prefs = Get.find<SharedPredManager>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<Status> listStatus = <Status>[].obs;
  var isLoading = true.obs;

  Future<void> getStatus() async {
    try {
      CollectionReference status = fireabseFireStore.collection('status');
      QuerySnapshot querySnapshot = await status.get();
      querySnapshot.docs.forEach((e) {
        listStatus.add(Status.fromJson(e.data() as Map<String, dynamic>));
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getUserNameById(String? id) async {
    Map<String, dynamic> data = await fireabseFireStore
        .collection('users')
        .where('id', isEqualTo: id)
        .get() as Map<String, dynamic>;
    String name = MyUser.User.fromJson(data).firstName;
    String lastName = MyUser.User.fromJson(data).lastName;
    return "$name $lastName";
  }

  Future<void> getUsers() async {
    try {
      var getIds = listStatus.map((e) => e.userId).toList();
      if (getIds.isNotEmpty) {
        CollectionReference users = firebaseFirestore.collection("users");
        QuerySnapshot querySnapshot =
            await users.where('id', whereIn: getIds).get();
        querySnapshot.docs.forEach((e) {
          listUsers.add(MyUser.User.fromJson(e.data() as Map<String, dynamic>));
        });
      }
      listUsers;
      update();
    } catch (e) {
      throw Exception(e);
    }finally{
      isLoading.value=false;
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      prefs.clearAll();
      Get.offAllNamed(RoutesNames.login);
    } catch (e) {
      throw Exception(e);
    }
  }

  showAlertAddStatus() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Write your status and share it",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }

  getDataOfCurrentUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        QuerySnapshot userDataSnapshot = await firebaseFirestore
            .collection('users')
            .where("id", isEqualTo: user.uid)
            .get();
        if (userDataSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
              userDataSnapshot.docs.first.data() as Map<String, dynamic>;
          MyUser.User currentUser = MyUser.User.fromJson(userData);
          prefs.saveString("userData", jsonEncode(currentUser.toJson()));
        } else {
          await logout();
        }
      } else {
        await logout();
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  checkAndSave() async {
    String? userData = prefs.getString("userData");
    if (userData == null || userData.isEmpty) {
      await getDataOfCurrentUser();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkAndSave();
    await getStatus();
    await getUsers();
  }
}
