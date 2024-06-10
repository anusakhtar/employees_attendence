import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> options;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  CustomDropdownButton({super.key, required this.options, this.value, this.onChanged, this.validator});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('Select one'),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 17,vertical:17 ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
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
      ),
      value: widget.value,
      items: widget.options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}

