import 'package:flutter/material.dart';
import 'package:myapp/data/models/enums.dart';
import 'package:get/get.dart';

class Tag {
  final Tags tag;
  final IconData? icon;
  var isSelected = false.obs;

  Tag(this.tag,{this.icon});

  factory Tag.fromJson(Map<String, dynamic> data) {
    return Tag(
        data['tag']!=null?
         Tags.values.firstWhere(
              (e) => e.toString().split('.').last == data['tag'],
              orElse: () => Tags.Other):Tags.Other
      );
  }


  Map<String, dynamic> toJson() {
    return {
      'tag': tag.toString().split('.').last,
      "isSelected": isSelected.value,
    };
  }
}
