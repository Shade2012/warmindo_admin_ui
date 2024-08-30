import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class ForgotPassController extends GetxController {
  var isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changePass({
    required String password,
    required String password_confirmation,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenForgot'); 

    if (token == null) {
      Get.snackbar(
        'Error',
        'No token found. Please verify OTP again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final url = Uri.parse(AuthEndpoint().changePassword);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'password': password,
        'password_confirmation': password_confirmation,
        'token': token, 
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
      print('Failed to change password ${response.statusCode}. Response: ${response.body}');
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
