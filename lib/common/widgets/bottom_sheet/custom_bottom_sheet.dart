import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import '../../../data/models/status.dart';

class CustomBottomSheet extends StatelessWidget {
  final Status status;
  const CustomBottomSheet({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomSheetController>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<BottomSheetController>(
                builder:(_) {
              return controller.listComments.isEmpty
                ? const Center(
                    child: Text(
                      'No comments yet',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                : Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                      child: ListView.builder(
                        itemCount: controller.listComments.length,
                        itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomListTile(
                              isComment: true,
                              profileUrl: controller.listComments[index].profileUrl,
                              title: controller.listComments[index].userFullName ??'',
                              subtitle: controller.listComments[index].content,
                              userId:controller.listComments[index].userId ,
                              uid:controller.listComments[index].id ,
                              statusId: controller.listComments[index].statusId,
                            ),
                          );
                        },
                      ),
                    );
                  }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: const EdgeInsets.only(
                bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(239, 236, 232, 232),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textCommentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,color: Colors.black,),
                  onPressed: () async {
                    try {
                      await controller.commentUpdate(status);
                      status.commentCount = (int.parse(status.commentCount == ''
                                  ? '0'
                                  : status.commentCount ?? '0') +
                              1)
                          .toString();
                    } catch (e) {
                      Exception(e);
                    }
                    controller.textCommentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
