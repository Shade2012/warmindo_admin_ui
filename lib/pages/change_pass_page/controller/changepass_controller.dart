import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class ChangePassController extends GetxController {
  RxBool isLoading = false.obs;
  final cntrlPassword = RxString("");
  final token = RxString("");

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changePassword({
    required String password,
    required String current_password,
    required String password_confirmation,
  }) async {
    final url = Uri.parse(AuthEndpoint().updateAdminData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final client = http.Client();

    if (token == null) {
      Get.snackbar(
        'Error',
        'Token tidak ditemukan. Silakan login kembali.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'password': password,
          'current_password': current_password,
          'password_confirmation': password_confirmation,
        }),
      );

      final responseData = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 201) {
        Get.snackbar(
          'Berhasil',
          'Password berhasil diubah',
          snackPosition: SnackPosition.TOP,
        );
        logOut();
      } else {
        Get.snackbar(
          'Gagal',
          responseData['message'] ?? 'Password Gagal Diubah',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      client.close();
    }
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('email');
    prefs.remove('password');
    Get.offAllNamed(Routes.SPLASH_PAGE);
  }
}
