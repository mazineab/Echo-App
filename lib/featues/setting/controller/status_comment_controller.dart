import 'package:get/get.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/repositories/home_repo.dart';
import 'package:myapp/featues/home/controller/current_user_controller.dart';

class StatusCommentController extends GetxController{
  RxList<Status> listStatus=<Status>[].obs;
  RxList<Comment> listComments=<Comment>[].obs;
  var isLoad=true.obs;
  HomeRepo homeRepo=Get.put(HomeRepo());

  Future<void> fetchStatus()async{
    try{
      List<Status> list= await homeRepo.getStatusOfUser(Get.find<CurrentUserController>().me.value.id);
      listStatus.assignAll(list);

    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!, "Faild to load your Status");
    }finally{
      await Future.delayed(const Duration(milliseconds: 30));
      isLoad.value=false;
    }
  }

  Future<void> fetchComments()async{
    try{
      List<Comment> list= await homeRepo.getCommentOfUser(Get.find<CurrentUserController>().me.value.id);
      listComments.assignAll(list);

    }catch(e){
      CustomSnackbar.showErrorSnackbar(Get.context!, "Faild to load your Status");
    }finally{
      await Future.delayed(const Duration(milliseconds: 30));
      isLoad.value=false;
    }
  }

  @override
  void onInit()async {
    super.onInit();
    await fetchStatus();
    await fetchComments();
  }
}