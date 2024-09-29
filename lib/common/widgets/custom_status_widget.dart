import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:myapp/common/widgets/custom_list_tile.dart';
import 'package:myapp/data/models/like.dart';
import 'package:myapp/featues/home/controller/home_controller.dart';

import '../../data/models/status.dart';

// ignore: must_be_immutable
class CustomStatusWidget extends StatelessWidget {
  final String fullName;
  final Status status;
  CustomStatusWidget({super.key, required this.fullName, required this.status});

  final controller = Get.find<HomeController>();
  var lenghtOf = 0.obs;
  var lenghtOfComments = 0.obs;
  @override
  Widget build(BuildContext context) {
    var likes = status.listLikes!.length.obs;
    var comments = status.listComments!.length.obs;
    lenghtOf.value = likes.value;
    lenghtOfComments.value = comments.value;
    return Column(
      children: [
        CustomListTile(
          id: status.userId,
          title: fullName,
          subtitle: status.content,
          isComment: true,
        ),
        Container(
          margin: const EdgeInsets.only(left: 85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   status.content,
              //   style: const TextStyle(fontSize: 17),
              // ),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildDate(status),
                  const SizedBox(
                    width: 20,
                  ),
                  buildIconLikeText(status),
                  const SizedBox(
                    width: 20,
                  ),
                  buildIconCommentText(status),
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

  Widget buildDate(Status status) {
    return Row(
      children: [
        Icon(Icons.calendar_month, color: Colors.grey.shade400),
        Text(
          status.formattedCreatedAt(),
          style: const TextStyle(
              fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
        ),
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
                    : lenghtOf.value.toString() == '0'
                        ? ''
                        : lenghtOf.value.toString(),
              ),
            ],
          ),
        ));
  }

  Widget buildIconCommentText(Status status) {
    return GestureDetector(
      onTap: () async {
        await controller.getCommants(status);
        showModalBottomSheet(
            isScrollControlled: true,
            context: Get.context!,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: CustomBottomSheet(status: status),
              );
            });
        controller.update();
      },
      child: GetBuilder<HomeController>(
        builder: (_) => Row(
          children: [
            const Icon(
              Icons.comment,
              color: Color.fromARGB(255, 212, 212, 212),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(status.commentCount == null || status.commentCount!.isEmpty
                ? ""
                : status.commentCount == '0'
                    ? ''
                    : status.commentCount.toString()),
          ],
        ),
      ),
    );
  }
}
