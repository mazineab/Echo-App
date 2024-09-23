import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';
import '../../../data/models/status.dart';

class CustomBottomSheet extends StatelessWidget {
  final Status status;
  const CustomBottomSheet({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2, // Fixed height of 400
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<HomeController>(builder: (_) {
              return 
              status.listComments!.isEmpty
                ? const Center(
                    child: Text(
                      'No comments yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                      child: ListView.builder(
                        itemCount: status.listComments!.length,
                        itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomListTile(
                              isComment: true,
                              title: status.listComments![index].userFullName ??
                                  '',
                              subtitle: status.listComments![index].content,
                              id:status.listComments![index].userId ,
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
              color: const Color.fromARGB(69, 215, 212, 212),
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
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    try {
                      await controller.commentUpdate(status.id!);
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
