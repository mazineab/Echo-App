import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_names.dart';

class CustomTextNavigation extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onTap;
  const CustomTextNavigation({super.key,required this.firstText,required this.secondText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            firstText,
          ),
          TextButton(
              onPressed:onTap,
              child: Text(
                secondText
              ))
        ],
      ),
    ));
  }
}
