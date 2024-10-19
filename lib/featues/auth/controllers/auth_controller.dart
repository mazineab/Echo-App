import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/enums.dart';
import 'package:myapp/data/models/user.dart' as me;

import 'package:myapp/data/repositories/auth_repo.dart';
import 'package:myapp/routes/routes_names.dart';

class AuthController extends GetxController {
  final prefs = Get.find<SharedPredManager>();
  var isload = false.obs;

  final authRepo=Get.put(AuthRepo());

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

  Future<void> login()async{
    isload.value = true;
    Future.delayed(const Duration(milliseconds: 500));
    try {
      bool islogin=await authRepo.login(emailController.text, passwordController.text);
      if (islogin) {
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
      var userData={
        'email':emailController.text,
        'password':passwordController.text,
        'firstName':firstNameController.text,
        'lastName':lastNameController.text,
        'phone':phoneController.text,
        'sexe':sexeVal
      };
      bool isRegister=await authRepo.register(userData);
      if(isRegister){
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
    try{
      final me.User user=await authRepo.getDataOfCurrentUser()??me.User.empty();
      if(user.id.isEmpty){
        await logout();
      }else{
        prefs.saveString("userData", jsonEncode(user.toJson()));
      }

    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!, "Error:$e");
      await logout();
    }
  }

  Future<void> logout() async {
    try {
      authRepo.logout();
      prefs.clearAll();
      Get.offAllNamed(RoutesNames.login);
    } catch (e) {
      throw Exception(e);
    }
  }
}
