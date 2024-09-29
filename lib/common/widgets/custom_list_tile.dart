import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/common/widgets/image_widget.dart';
import 'package:myapp/featues/home/screens/profile.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isComment;
  final String id;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.id,
      this.isComment = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(Profile(
          isMyProfile: false,
          userId: id,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            ImageWidget(
              userName: title,
            ),
            const SizedBox(
              width: 13,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  // isComment?
                  Text(subtitle,
                      style: TextStyle(fontSize: isComment ? 18 : 13))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
