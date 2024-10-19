import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/data/repositories/auth_repo.dart';
import '../../../common/drawer/custom_drawer_controller.dart';
import '../../../core/utils/localStorage/shared_pref_manager.dart';
import 'package:myapp/data/models/user.dart' as my_user;

import '../../../routes/routes_names.dart';

class CurrentUserController extends GetxController{
  final SharedPredManager prefs = Get.find<SharedPredManager>();
  var me=my_user.User.empty().obs;
  final AuthRepo authRepo=Get.put(AuthRepo());

  getUserData() {
    String? userData = prefs.getString("userData");
    if (userData != null && userData.isNotEmpty) {
      me.value= my_user.User.fromJson(jsonDecode(userData));
    }
  }

  Future<void> logout() async {
    try {
      await authRepo.logout();
      prefs.clearAll();
      Get.delete<CurrentUserController>();
      Get.delete<CustomDrawerController>();
      Get.delete<CurrentUserController>();
      Get.offAllNamed(RoutesNames.login);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void onInit()async {
    super.onInit();
    getUserData();
  }

}