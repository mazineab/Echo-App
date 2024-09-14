import 'package:flutter/material.dart';
import 'package:myapp/data/models/enums.dart';

class Tag {
  final Tags tag;
  final IconData icon;
  RxBool isSelected ;

  Tag(this.tag, this.icon, {this.isSelected = false.obs});
}
