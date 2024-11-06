import 'package:get/get.dart';
import 'package:myapp/data/models/user.dart' as my_user;

import '../../../common/dialogs/custom_snackbar.dart';
import '../../../data/repositories/home_repo.dart';


class UsersListController extends GetxController{
  List<my_user.User> listUsers=<my_user.User>[].obs;
  var isLoad=true.obs;
  HomeRepo homeRepo=Get.put(HomeRepo());

  Future<void> fetchUsers()async{
    try{
      List<my_user.User> list=await homeRepo.getUsers();
      listUsers.assignAll(list);
    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!, "Faild to load Users");
    }finally{
      await Future.delayed(const Duration(milliseconds: 30));
      isLoad.value=false;
    }
    update();
  }

  @override
  void onInit()async {
    await fetchUsers();
    super.onInit();
  }
}