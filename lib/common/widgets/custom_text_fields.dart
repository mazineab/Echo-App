import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool hasMargin;

  const CustomTextFeild(
      {super.key,
      required this.label,
      required this.controller,
      required this.isPassword,
      this.hasMargin = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal:
              hasMargin ? MediaQuery.of(context).size.width / 18 : 20.0),
      height: 50,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
