import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/controller/general_info_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class LoginController extends GetxController {
  final firebaseMessaging = FirebaseMessaging.instance;
  final GeneralInformationController generalinfo = Get.put(GeneralInformationController());
  RxBool isLoading = false.obs;
  var obscureText = true.obs;
  var token = ''.obs;
  var email = ''.obs;
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();

  Future<void> loginAdmin(String email, String password) async {
    String? notificationToken;
    await firebaseMessaging.getToken().then((value) {
      notificationToken = value;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true; 
    final url = Uri.parse(AuthEndpoint().login);

    final client = http.Client();
    try {
      print('token fcm di login: $notificationToken');
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'notification_token': notificationToken,
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
