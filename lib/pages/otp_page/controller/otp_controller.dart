import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  var tokenForgot = ''.obs;

  Future<void> sendOtp(String email) async {
    isLoading.value = true; // Set loading state to true
    try {
      final url = Uri.parse(AuthEndpoint().checkEmail);
      var request = http.MultipartRequest('POST', url)
        ..fields['email'] = email
        ..headers['Accept'] = 'application/json';
        
      var response = await request.send();
      
      if (response.statusCode == 200) {
        // Optionally, read the response body
        final responseBody = await response.stream.bytesToString();
        print('OTP sent: $responseBody');
        Get.snackbar(
          'Success',
          'OTP has been sent to $email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print('Failed to send OTP. Status code: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'Failed to send OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred while sending OTP.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  Future<void> verifyOtp(String otp, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoading.value = true; 
  try {
    final url = Uri.parse(AuthEndpoint().verifyEmail);
    var request = http.MultipartRequest('POST', url)
      ..fields['otp'] = otp
      ..fields['email'] = email
      ..headers['Accept'] = 'application/json';
      
    var response = await request.send();
    
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);
      
      if (jsonResponse['status'] == 'success') {
        String token = jsonResponse['token'];   
        prefs.setString('tokenForgot', token); 
        print('OTP verified: $responseBody');
        Get.snackbar(
          'Success',
          'OTP has been verified successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(Routes.FORGOT_PASS);
      } else {
        Get.snackbar(
          'Error',
          'OTP verification failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      print('Failed to verify OTP. Status code: ${response.statusCode}');
      Get.snackbar(
        'Error',
        'Failed to verify OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    print('Error: $e');
    Get.snackbar(
      'Error',
      'An error occurred while verifying OTP.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isLoading.value = false; 
  }
}
}