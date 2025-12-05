import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const MyTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    const Color themeColor = Color(0xFF3E8B3A);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),

        // Border when NOT focused
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3E8B3A), width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        // Border when focused
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3E8B3A), width: 1.8),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        // Border when error happens
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.8),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        // Floating label color when focused
        floatingLabelStyle: const TextStyle(
          color: themeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
