import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';

class InputNotificationController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isConnected = true.obs;
  RxString token = "".obs;
  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  void checkConnectivity() async {
    await initializePrefs();
    if (prefs != null) {
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
      token.value = prefs!.getString('token') ?? '';
      print("Token: ${token.value}");
      if (token.value.isNotEmpty) {
        print("Token is not empty");
      } else {
        print("Token is empty");
      }
    }
  }

 Future<void> sendNotification() async {
  if (title.value.isEmpty || description.value.isEmpty) {
    Get.snackbar(
      'Warning',
      'Semua data harus diisi',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
    return;
  }

  isLoading.value = true;
  try {
    var uri = Uri.parse(NotificationApi.sendnotificationtoAll);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Authorization': 'Bearer ${token.value}',
        'Accept': 'application/json',
      })
      ..fields['title'] = title.value
      ..fields['body'] = description.value;

    var response = await request.send();

    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar(
        'Success',
        'Notifikasi berhasil dikirim',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      var responseBody = await response.stream.bytesToString();
      print('Failed to send notification: ${response.statusCode}');
      print('Response Body: $responseBody');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengirim notifikasi: $responseBody',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'Terjadi kesalahan saat mengirim notifikasi: $e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isLoading.value = false;
  }
}
}