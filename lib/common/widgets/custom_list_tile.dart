import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/ask_dialog.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/data/models/status.dart';
import 'package:myapp/data/repositories/status_repo.dart';
import 'package:myapp/featues/auth/controllers/auth_controller.dart';
import 'package:myapp/featues/home/controller/add_status_controller.dart';
import 'package:myapp/featues/home/controller/current_user_controller.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import 'package:myapp/featues/home/screens/profile.dart';
import 'package:myapp/routes/routes_names.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isComment;
  final String userId;
  String? uid;
  String? profileUrl;
  String? statusId;
  CustomListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.userId,
      this.profileUrl,
      this.uid,
        this.statusId,
      this.isComment = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool myProfile=Get.find<CurrentUserController>().me.value.firstName==title;
        Get.to(Profile(
          isMyProfile: myProfile,
          userId: userId,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 10),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: profileUrl??'',
              userName: title,
            ),
            const SizedBox(
              width: 13,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white),),
                  Text(subtitle,style: const TextStyle(fontSize:16,color: Colors.white))
                ],
              ),
            ),
            statusId==null && uid==null?SizedBox() :menuCondition()
          ],
        ),
      ),
    );
  }
  Widget menuCondition(){
    if(isComment){
      return buildMenu();
    }
    else if(userId==Get.find<CurrentUserController>().me.value.id){
      return buildMenu();
    }
    return const SizedBox();
  }

  Widget buildMenu(){
    return PopupMenuButton(
      iconColor: Colors.white,
      onSelected: (e)async{
        if(e=="delete" && !isComment && uid!=null){
          AskDialog.showDeleteConfirmationDialog(Get.context!,statusId:uid!,userId:userId);
        }
        if(e=="delete" && isComment && uid!=null && statusId!=null){
          AskDialog.showDeleteConfirmationDialog(Get.context!,statusId: statusId!,commentId: uid,userId: userId,isStatus: false);
        }

        if(e=='edit' && !isComment){
          await Get.put(AddStatusController()).setData(statusId!);
          Get.toNamed(RoutesNames.addStatus);
        }
      },
        itemBuilder: (context){
        if(!isComment){
          return [
            const PopupMenuItem(value: "delete",child: Text("Delete")),
            const PopupMenuItem(value: "edit",child: Text("Edit"))
          ];
        }else{
          return [
            const PopupMenuItem(value: "delete",child: Text("Delete")),
          ];
        }

        }
    );
  }
}
