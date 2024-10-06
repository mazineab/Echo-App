import 'dart:math';
import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  String? userName;
  String? imageUrl;
  ImageWidget({super.key,this.userName,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Avatar(
        name: userName,
        sources: [if(imageUrl!=null && imageUrl!.isNotEmpty) NetworkSource(imageUrl!)],
        useCache: true,
        backgroundColor:imageUrl!=null && imageUrl!.isNotEmpty ?Colors.transparent:getRandomColor(),
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0, // Opacity
    );
  }

}
