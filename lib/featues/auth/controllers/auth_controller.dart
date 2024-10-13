import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/enums.dart';
import 'package:myapp/data/models/user.dart' as myuser;
import 'package:myapp/routes/routes_names.dart';

class AuthController extends GetxController {
  final firabaseAuth = FirebaseAuth.instance;
  final fireabseFireStore = FirebaseFirestore.instance;
  final prefs = Get.find<SharedPredManager>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var isload = false.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String? sexeVal;
  changeSexeVal(String val) {
    sexeVal = val;
    update();
  }

  @override
  onInit() {
    super.onInit();
    emailController.text = "Mazine@gmail.com";
    passwordController.text = "Mazine@123";
  }

  Future<void> login() async {
    isload.value = true;
    Future.delayed(const Duration(seconds: 1));
    try {
      UserCredential user = await firabaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (user.user != null) {
        await getDataOfCurrentUser();
        Get.offNamed(RoutesNames.home);
      }
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(Get.context!,"Something went wrong");
    } finally {
      isload.value = false;
    }
  }

  Future<void> register() async {
    isload.value = true;
    final listControllers = [
      emailController,
      firstNameController,
      lastNameController,
      phoneController,
      passwordController
    ];
    try {
      UserCredential user = await firabaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (user.user != null) {
        Map<String,dynamic> data= {
          'id':user.user?.uid??'',
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'phoneNumber': phoneController.text,
          'sexe': sexeVal == "Male" ?  "male" : "femel",
          'password': passwordController.text,
        };
        myuser.User userReg = myuser.User.fromJson(data);
        DocumentReference docRef =await fireabseFireStore.collection('users').add(userReg.toJson());
        userReg.uId=docRef.id;
        await docRef.update(userReg.toJson());
        for (var e in listControllers) {
          e.text = "";
        }
        sexeVal = null;
      }
      CustomSnackbar.showSuccessSnackbar(Get.context!, 'success create your account');
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(Get.context!, 'Failed to create user');
    } finally {
      isload.value = false;
    }
  }

  getDataOfCurrentUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        QuerySnapshot userDataSnapshot = await fireabseFireStore
            .collection('users')
            .where("id", isEqualTo: user.uid)
            .get();
        if (userDataSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
          userDataSnapshot.docs.first.data() as Map<String, dynamic>;
          myuser.User user=myuser.User.fromJson(userData);
          prefs.saveString("userData", jsonEncode(user.toJson()));
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

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      prefs.clearAll();
      Get.offAllNamed(RoutesNames.login);
    } catch (e) {
      throw Exception(e);
    }
  }
}
