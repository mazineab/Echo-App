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
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
