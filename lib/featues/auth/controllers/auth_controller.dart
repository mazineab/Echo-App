import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/enums.dart';
import 'package:myapp/data/models/user.dart' as myUser;
import 'package:myapp/routes/routes_names.dart';

class AuthController extends GetxController {
  final firabaseAuth = FirebaseAuth.instance;
  final fireabseFireStore = FirebaseFirestore.instance;
  final prefs = Get.find<SharedPredManager>();
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
    Future.delayed(Duration(seconds: 1));
    try {
      UserCredential user = await firabaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (user.user != null) {
        Get.offNamed(RoutesNames.home);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red);
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
        await fireabseFireStore.collection('users').add(myUser.User(
              id: user.user!.uid,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              phoneNumber: phoneController.text,
              sexe: sexeVal == "Male" ? Sexe.male : Sexe.male,
              password: passwordController.text,
            ).toJson());
        for (var e in listControllers) {
          e.text = "";
        }
        sexeVal = null;
      }
      // a.collection('roles').add({'name': 'user'});
      Get.snackbar('Success', 'success create your account',
          colorText: Colors.white, backgroundColor: Colors.green);
      //navigation to home
    } catch (e) {
      Get.snackbar('Error', 'Failed to create user',
          colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      isload.value = false;
    }
  }
}
