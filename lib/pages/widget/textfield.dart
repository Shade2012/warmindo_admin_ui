import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final int minLines;
  final int maxLines;

  const CustomTextField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = "",
    this.minLines = 1,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          hintStyle: contentAddProductTextStyle),
    );
  }
}
