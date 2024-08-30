import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';

class GeneralInformationController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  RxString image = "".obs;
  RxString name = "".obs;
  RxString username = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString token = "".obs;
  var fullName = "".obs;
  SharedPreferences? prefs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    initializeControllers();
  }

  void setFullName(String value) {
    fullName.value = name.value;
  }

  void initializeControllers() {
    fullNameController.text = name.value;
    usernameController.text = username.value;
    emailController.text = email.value;
    phoneNumberController.text = phoneNumber.value;
  }

  void checkConnectivity() async {
    await initializePrefs();
    if (prefs != null) {
      username.value = prefs!.getString('username') ?? '';
      token.value = prefs!.getString('token') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        checkSharedPreference();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      checkSharedPreference();
    }
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      username.value = prefs!.getString('username') ?? '';
      token.value = prefs!.getString('token') ?? '';
      print("Token: ${token.value}");
      if (token.value.isNotEmpty) {
        fetchData();
      } else {
        print("Token is empty");
      }
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AuthEndpoint().detailUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
          "Accept": "application/json",
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        final userData = responseData['data']; // Mengakses data dengan benar

        // Pastikan userData tidak null sebelum mengakses
        if (userData != null) {
          username.value = userData['username'] ?? '';
          name.value = userData['name'] ?? '';
          email.value = userData['email'] ?? '';
          phoneNumber.value = userData['phone_number'] ?? '';
          image.value = userData['profile_picture'] ?? '';

          // Update TextEditingControllers
          fullNameController.text = name.value;
          emailController.text = email.value;
          phoneNumberController.text = phoneNumber.value;
          usernameController.text = username.value;
        } else {
          print("User data is null");
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
