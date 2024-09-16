import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import 'package:myapp/data/models/like.dart';
import 'package:myapp/data/models/user.dart' as MyUser;
import 'package:myapp/featues/home/controller/home_controller.dart';

import '../../data/models/status.dart';

class CustomStatusWidget extends StatelessWidget {
  final MyUser.User user;
  final Status status;
  CustomStatusWidget({super.key, required this.user, required this.status});

  final controller = Get.find<HomeController>();
  var lenghtOf = 0.obs;
  @override
  Widget build(BuildContext context) {
    var likes = status.listLikes!.length.obs;
    lenghtOf.value = likes.value;
    return Column(
      children: [
        CustomListTile(
          title: "${user.firstName} ${user.lastName}",
          subtitle: "15/09/2024",
        ),
        Container(
          margin: const EdgeInsets.only(left: 85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(status.content),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildIconLikeText(status),
                  const SizedBox(
                    width: 20,
                  ),
                  buildIconCommentText(
                    Icons.comment,
                    status.listComments == null || status.listComments!.isEmpty
                        ? ""
                        : status.listComments!.length.toString(),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
        const Divider(
          color: Color.fromARGB(24, 0, 0, 0),
        )
      ],
    );
  }

  Widget buildIconLikeText(Status status) {
    var isLiked = false.obs;
    for (var e in status.listLikes!) {
      if (e.userId == controller.myId.value) {
        isLiked.value = true;
        break;
      } else {
        continue;
      }
    }

    return Obx(() => GestureDetector(
          onTap: () {
            Like like = Like(userId: controller.myId.value, status: status.id!);
            controller.likeUpdates(like);
            isLiked.value = !isLiked.value;
            status.listLikes!.add(like);
            if (isLiked.value) {
              lenghtOf + 1;
            } else {
              lenghtOf - 1;
            }
          },
          child: Row(
            children: [
              Icon(
                isLiked.value
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: isLiked.value
                    ? Colors.red
                    : const Color.fromARGB(255, 212, 212, 212),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                status.listLikes == null || status.listLikes!.isEmpty
                    ? ""
                    : lenghtOf.value.toString()=='0'?'':lenghtOf.value.toString(),
              ),
            ],
          ),
        ));
  }

  Widget buildIconCommentText(
    IconData icon,
    String text,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 212, 212, 212),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(text),
        ],
      ),
    );
  }
}
