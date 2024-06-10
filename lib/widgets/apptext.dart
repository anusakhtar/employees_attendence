import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final AlignmentGeometry? alignment;
  final TextAlign? textAlign;
  const AppText({super.key, required this.text, this.fontSize, this.fontWeight, this.alignment, this.textColor, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign:textAlign,
      text,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight,
        color: textColor,

      ),
    );
  }
}
