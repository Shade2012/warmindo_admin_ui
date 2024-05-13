import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVoucherController extends GetxController {
  void pickedDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate != null) {
      // Lakukan sesuatu dengan tanggal yang dipilih, misalnya set nilai pada TextEditingController
    }
  }
}
