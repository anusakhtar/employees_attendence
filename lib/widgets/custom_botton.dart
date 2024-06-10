import 'package:flutter/material.dart';

import 'apptext.dart';


class CustomBotton extends StatelessWidget {
  final double? height, width, borderRadius, fontSize;
  final Color? backgroundColor, textColor, borderColor;
  final String?  label;
  final FontWeight? fontWeight;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const CustomBotton(
      {super.key,
      this.height,
      this.width,
      this.borderRadius,
      this.backgroundColor,
      this.label,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.borderColor,
      this.border,
      this.padding,
      this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        height: height ?? 55,
        width: width ?? 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
          border: border ??
              Border.all(
                color: borderColor ?? Colors.transparent,
                width: 1,
              ),
          color: backgroundColor ?? Colors.deepPurple,
        ),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(
              fontWeight: fontWeight ?? FontWeight.w600 ,
              fontSize: fontSize ?? 14,
              color: textColor??Colors.white,
            ),
          ),
        )
      ),
    );
  }
}
