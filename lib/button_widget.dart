import 'package:flutter/material.dart';

import 'text_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.bgColor = Colors.black, this.textColor, this.buttonSize = const Size(double.infinity, 56), required this.onPressed, required this.title, this.child});

  final Color? bgColor;
  final Size buttonSize;
  final Color? textColor;
  final VoidCallback onPressed;
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: buttonSize, shape: const StadiumBorder(), backgroundColor: bgColor),
      onPressed: onPressed,
      child: child ??
          CustomText(
            text: title,
            color: textColor!,
            size: 16.0,
            weight: FontWeight.w500,
            align: TextAlign.center,
          ),
    );
  }
}
