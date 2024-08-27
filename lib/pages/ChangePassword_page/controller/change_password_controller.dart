import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class ForgotPassController extends GetxController {
  var isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changePass ({
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    final url = Uri.parse(AuthEndpoint().changePassword);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed(Routes.SPLASH_PAGE);
    } else {
      Get.snackbar(
        'Error',
        'Failed to change password ${response.statusCode}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
