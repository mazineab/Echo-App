import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/data/models/user.dart' as myUser;

class AuthController extends GetxController {
  final firabaseAuth = FirebaseAuth.instance;
  final fireabseFireStore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> login() async {
    try {
      firabaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //navigation to home
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          backgroundColor: Colors.red);
    }
  }

  Future<void> register() async {
    try {
      UserCredential user = await firabaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (user.user != null) {
        await fireabseFireStore.collection('users').add(myUser.User(
              id: user.user!.uid,
              name: usernameController.text,
              email: emailController.text,
              city: cityController.text,
              password: passwordController.text,
            ).toJson());
      }

      // a.collection('roles').add({'name': 'user'});
      Get.snackbar('Success', 'success create your account',
          colorText: Colors.white, backgroundColor: Colors.green);
      //navigation to home
    } catch (e) {
      Get.snackbar('Error', 'Failed to create user',
          backgroundColor: Colors.red);
    }
  }
}
