import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as myuser ;
import 'package:myapp/data/repositories/status_repo.dart';
import 'package:myapp/featues/home/controller/current_user_controller.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';

import '../../../data/models/user.dart';
import '../../../data/models/user.dart';
import '../../dialogs/custom_snackbar.dart';

class BottomSheetController extends GetxController{
  final StatusRepo _statusRepo=Get.put(StatusRepo());
  final CurrentUserController currentUserController=Get.find();
  HomeController homeController=Get.find();


  RxList<Comment> listComments=<Comment>[].obs;
  var textCommentController = TextEditingController();




  commentUpdate(Status status) async {
    try {
      Comment comment = Comment(
          id: '',
          userId: myId.value,
          content: textCommentController.text,
          userFullName: fullName.value,
          profileUrl: imageUrl.value,
          createAt: DateTime.now().toString(),
          statusId: status.id!);
      bool isUpdate=await _statusRepo.commentUpdate(status, comment);
      if(isUpdate){
        await homeController.getCommants(status);
        update();
      }else{
        CustomSnackbar.showErrorSnackbar(Get.context!,"Faild add your comment");
      }
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(Get.context!,"Faild add your comment");
      throw Exception(e);
    }
  }


  setListComment(List<Comment> comments){
    listComments.assignAll(comments);
    update();
  }

  var fullName = "".obs;
  var myId = ''.obs;
  var imageUrl=''.obs;
  getUserData() {
    myuser.User currentUser = currentUserController.me.value;
    fullName.value = "${currentUser.firstName} ${currentUser.lastName}";
    myId.value = currentUser.id;
    imageUrl.value=currentUser.imageUrl??'';
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

}