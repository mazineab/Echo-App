import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/dialogs/ask_dialog.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/data/repositories/status_repo.dart';
import 'package:myapp/featues/home/controller/current_user_controller.dart';
import 'package:myapp/featues/home/screens/profile.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isComment;
  final String userId;
  String? uid;
  String? profileUrl;
  CustomListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.userId,
      this.profileUrl,
      this.uid,
      this.isComment = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(Profile(
          isMyProfile: false,
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
                  Text(title,style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  Text(subtitle,style: const TextStyle(fontSize:16))
                ],
              ),
            ),
            userId==Get.find<CurrentUserController>().me.value.id?
            buildMenu():const SizedBox()
          ],
        ),
      ),
    );
  }
  
  Widget buildMenu(){
    return PopupMenuButton(
      onSelected: (e)async{
        if(e=="delete" && !isComment && uid!=null){
          AskDialog.showDeleteConfirmationDialog(Get.context!,uid!,userId);
        }
      },
        itemBuilder: (context){
          return [
            PopupMenuItem(value: "delete",child: Text("Delete")),
            PopupMenuItem(value: "edit",child: Text("Edit"))
          ];
        }
    );
  }
}
