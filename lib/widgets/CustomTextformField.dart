import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final double? height;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Color? bgColor,suffixIconColor,borderColor;
  final void Function()? onTapSuffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
 final  void Function(String)? onFieldSubmitted;
  const CustomTextFormField(
      {super.key,
      this.prefixIcon,
      required this.hintText,
      this.controller,
      this.bgColor,
      this.suffixIcon,
        this.onTapSuffixIcon,
        this.suffixIconColor,
        this.contentPadding, this.borderColor, this.onFieldSubmitted, this.maxLines, this.height, this.validator, this.obscureText, this.keyboardType, this.inputFormatters,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ,
      child: TextFormField(
        inputFormatters:inputFormatters,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        validator: validator,
        maxLines: maxLines ?? 1,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        cursorColor:Colors.deepPurple,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onTapSuffixIcon,
                  child: Icon(
                    suffixIcon,
                    color: suffixIconColor ?? Colors.deepPurple,
                    size: 22,
                  ),
                )
              : null,
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor??Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1.5, color: Colors.deepPurple),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding:contentPadding ?? EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        ),
      ),
    );
  }
}
