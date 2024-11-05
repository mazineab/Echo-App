import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/colors.dart';
import '../../../common/widgets/custom_list_tile.dart';
import '../../../common/widgets/custom_status_widget.dart';
import '../controller/status_comment_controller.dart';

class CommentsList extends StatelessWidget {
  CommentsList({super.key});

  final StatusCommentController controller = Get.put(StatusCommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 40.0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Your Comment',style: TextStyle(color: Colors.white)),
            ),
            backgroundColor: MyColors.appBarColor,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          Obx(() {
            if (controller.isLoad.value) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: MyColors.colorbl,
                      ),
                    ),
                  ],
                ),
              );
            }else if(!controller.isLoad.value && controller.listComments.isEmpty){
              return const SliverFillRemaining(
                child: Center(
                    child: Text("You don't have any Comment in this app yet.",style: TextStyle(color: Colors.white))
                ),
              );
            }
            else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    controller.listComments[index];
                    return  CustomListTile(
                      isComment: true,
                      profileUrl: controller.listComments[index].profileUrl,
                      title: controller.listComments[index].userFullName ??'',
                      subtitle: controller.listComments[index].content,
                      userId:controller.listComments[index].userId ,
                      uid:controller.listComments[index].id ,
                      statusId: controller.listComments[index].statusId,
                    );
                  },
                  childCount: controller.listComments.length,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
