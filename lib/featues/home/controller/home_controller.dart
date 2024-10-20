import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/custom_snackbar.dart';
import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/like.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/models/user.dart' as myuser;
import 'package:myapp/data/repositories/status_repo.dart';
import 'package:myapp/featues/home/controller/current_user_controller.dart';

import '../../../common/drawer/custom_drawer_controller.dart';
import '../../../core/utils/localStorage/shared_pref_manager.dart';

class HomeController extends GetxController {
  final currentUserController=Get.find<CurrentUserController>();
  final StatusRepo _statusRepo=Get.put(StatusRepo());
  myuser.User cur=myuser.User.empty();

  // var listUsers = <myuser.User>[].obs;
  final prefs = Get.find<SharedPredManager>();
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<Status> listStatus = <Status>[].obs;
  var isLoading = true.obs;
  var fullName = "".obs;
  var myId = ''.obs;
  var imageUrl=''.obs;
  var isEmptyList = false.obs;


  Future<void> getStatus({bool isRefresh = false}) async {
    if (isRefresh) {
      listStatus.clear();
    }
    try {
      listStatus=await _statusRepo.getStatus();
      if (listStatus.isEmpty) {
        isEmptyList.value = true;
      } else {
        isEmptyList.value = false;
      }
      listStatus.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      update();
    } catch (e) {
      throw Exception(e);
    }finally{
      isLoading.value=false;
    }
  }

  Stream<List<Status>> getStatuss() {
    try{
      return  _statusRepo.getStatuss();
    }catch(e){
      throw Exception(e);
    }
  }

  Future<String> getUserNameById(String? id) async {
    return await _statusRepo.getUserNameById(id);
  }

  showAlertAddStatus() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Write your status and share it",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }


  getUserData() {
      myuser.User currentUser = currentUserController.me.value;
      fullName.value = "${currentUser.firstName} ${currentUser.lastName}";
      myId.value = currentUser.id;
      imageUrl.value=currentUser.imageUrl??'';
  }

  likeUpdates(Like like) async {
    try {
      DocumentReference docRef =
      firebaseFireStore.collection('status').doc(like.status);
      DocumentSnapshot docSnp = await docRef.get();

      if (docSnp.exists) {
        List<dynamic> listLikes = docSnp['listLikes'] ?? [];
        var userLike = listLikes.firstWhere(
          (lk) => myId.value == lk['userId'],
          orElse: () => null,
        );

        if (userLike == null) {
          listLikes.add(like.toJson());
        } else {
          listLikes.removeWhere((like) => like['userId'] == myId.value);
        }
        await docRef.update({'listLikes': listLikes});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getProfileOf(String uid)async{
    return await _statusRepo.getProfileOf(uid);
  }

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
        await getCommants(status);
        update();
      }else{
        CustomSnackbar.showErrorSnackbar(Get.context!,"Faild add your comment");
      }
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(Get.context!,"Faild add your comment");
      throw Exception(e);
    }
  }

  getCommants(Status status) async {
    try {
      List<Comment> listCmnt=await _statusRepo.getComments(status);
      status.listComments!.assignAll(listCmnt);
      status.listComments!.sort((a, b) =>
          DateTime.parse(b.createAt!).compareTo(DateTime.parse(a.createAt!)));
      update();
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Future<void> onInit() async {
    Get.put(CustomDrawerController());
    super.onInit();
    await getUserData();
    await getStatus();
    // await getAllUsers();
    // isLoading.value=false;
  }
}
