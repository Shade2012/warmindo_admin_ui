import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class EditOrderController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  RxString error = ''.obs;
  RxString token = "".obs;
  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    token.value = prefs?.getString('token') ?? '';
  }

  Future<void> updateOrder({
    required String orderId,
    String? userId,
    int? price,
    String? menuId,
    required String status,
    int? refund,
  }) async {
    try {
      isLoading.value = true;

      if (token.value.isEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Authorization token not found!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      var uri = Uri.parse('${OrderApi.editStatusOrder}$orderId');
      var request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = userId ?? ''
        ..fields['status'] = status
        ..fields['_method'] = 'put'
        ..headers['Accept'] = 'application/json'
        ..headers['Authorization'] = 'Bearer ${token.value}'; 

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        print('Order updated successfully');
        print('Response: ${response.body}');
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        print('Failed to update order: ${response.statusCode}');
        print('Response: ${response.body}');

        Get.snackbar(
          'Error',
          'Failed to update order!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to update order!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
