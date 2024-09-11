import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/data/models/enums.dart';
import 'package:myapp/data/models/user.dart' as myUser;
import 'package:myapp/routes/routes_names.dart';

class AuthController extends GetxController {
  final firabaseAuth = FirebaseAuth.instance;
  final fireabseFireStore = FirebaseFirestore.instance;

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

  Future<void> login() async {
    try {
      UserCredential user = await firabaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (user.user != null) {
        Get.offNamed(RoutesNames.home);
      }
      //navigation to home
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red);
    }
  }

  Future<void> register() async {
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
        listControllers.forEach((e) => e.text = "");
        sexeVal = null;
      }
      // a.collection('roles').add({'name': 'user'});
      Get.snackbar('Success', 'success create your account',
          colorText: Colors.white, backgroundColor: Colors.green);
      //navigation to home
    } catch (e) {
      Get.snackbar('Error', 'Failed to create user',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
}
