import 'package:flutter/material.dart';

@immutable
class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 5),
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Color(0xFF486eff)),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          onPressed: onTap,
          child: child),
    );
  }
}
