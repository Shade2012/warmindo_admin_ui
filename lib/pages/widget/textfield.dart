import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final int minLines;
  final int maxLines;
  final bool readOnly; // Tambahkan properti readOnly

  const CustomTextField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = "",
    this.minLines = 1,
    this.maxLines = 5,
    this.readOnly = false, // Inisialisasi properti readOnly dengan nilai default false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      readOnly: readOnly, // Set properti readOnly sesuai nilai yang diberikan
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: hintText,
        hintStyle: contentAddProductTextStyle,
      ),
    );
  }
}
