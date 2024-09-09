import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;

class ChangePassController extends GetxController {
  RxBool isLoading = false.obs;
  final cntrlPassword = RxString("");
  final token = RxString("");

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> changePassword({
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
      return false;
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Berhasil',
          'Password berhasil diubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          'Gagal',
          responseData['message'] ?? 'Password Gagal Diubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
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
      return false;
    } finally {
      client.close();
    }
  }
}
