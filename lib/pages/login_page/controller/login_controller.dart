import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  var obscureText = true.obs;
  var token = ''.obs;
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();

   void setToken(String newToken) {
    token.value = newToken;
  }

  String getToken() {
    return token.value;
  }

  Future<void> loginAdmin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true; 
    final url = Uri.parse(AuthEndpoint().login);

    final client = http.Client();
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final responData = jsonDecode(response.body);
        print(responData);
        print(response.statusCode);
        if (responData['admin'] != null) {
          prefs.setString('token', responData['token']);
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          prefs.setString('token', responData['token']);
          prefs.setString('email', ctrEmail.text);
          prefs.setString('password', ctrPassword.text);
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        }
      } else {
        Get.snackbar(
          'Error',
          'Email atau password kamu salah ni!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; 
      client.close();
    }
  }
}
