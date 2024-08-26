import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget typePass(
    TextInputType keyboardType,
    String label,
    TextEditingController controller,
    String? Function(String?)? validator,
    RxBool obscureText,
    double screenWidth,
    ) {
  return Container(
    width: screenWidth * 0.9, // Use screenWidth for responsive design
    child: Obx(() => TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText.value,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            obscureText.value = !obscureText.value;
          },
          icon: Icon(obscureText.value ? Icons.visibility : Icons.visibility_off),
          color: Colors.black,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),
      ),
      validator: validator,
    )),
  );
}
