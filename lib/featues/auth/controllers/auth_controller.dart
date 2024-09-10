import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      firabaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Get.snackbar('Success', 'success create your account',
          backgroundColor: Colors.green);
      //navigation to home
    } catch (e) {
      Get.snackbar('Error', 'Failed to create user',
          backgroundColor: Colors.red);
    }
  }
}
