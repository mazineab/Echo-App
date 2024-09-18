import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import 'package:myapp/data/models/comment.dart';
import 'package:myapp/data/models/user.dart' as MyUser;
import 'package:myapp/featues/home/controller/home_controller.dart';
import '../../../data/models/status.dart';

class CustomBottomSheet extends StatelessWidget {
  final Status status;

  const CustomBottomSheet({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return SizedBox(
      height: 400, // Fixed height of 400
      child: Column(
        children: [
          Expanded(
            child: status.listComments!.isEmpty
                ? const Center(
                    child: Text(
                      'No comments yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 60.0, top: 20),
                    child: ListView.builder(
                      itemCount: status.listComments!.length,
                      itemBuilder: (context, index) {
                        MyUser.User user = controller.listUsers.first;
                        for (var e in controller.listUsers) {
                          if (e.id == status.listComments![index].userId) {
                            user = e;
                            break;
                          } else {
                            continue;
                          }
                        }
                        return CustomListTile(
                          title: user.getFullName(),
                          subtitle: status.listComments![index].content,
                        );
                      },
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: const EdgeInsets.only(
                bottom: 10, left: 10, right: 10), // Bottom margin for spacing
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 212, 212),
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
                  onPressed: () {
                    controller.commentUpdate(status.id!);
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
