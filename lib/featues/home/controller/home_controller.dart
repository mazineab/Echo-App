import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/data/models/user.dart' as MyUser;
import 'package:myapp/routes/routes_names.dart';

class HomeController extends GetxController {
  var listUsers = <MyUser.User>[].obs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> getUsers() async {
    CollectionReference users = firebaseFirestore.collection("users");
    QuerySnapshot querySnapshot = await users.get();
    querySnapshot.docs.forEach((e) {
      listUsers.add(MyUser.User.fromJson(e.data() as Map<String, dynamic>));
    });
    listUsers;
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
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

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUsers();
  }
}
