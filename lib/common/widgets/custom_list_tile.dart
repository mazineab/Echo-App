import 'package:flutter/material.dart';
import 'package:myapp/common/widgets/image_widget.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomListTile({super.key,required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child:Row(
        children: [
          const ImageWidget(),
          const SizedBox(
            width: 13,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
              Text(subtitle,style:const TextStyle(fontSize: 16))
            ],
          )
        ],
      ),
    );
  }
}
