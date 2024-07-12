import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;

class EditOrderController extends GetxController {
  RxBool isLoading = true.obs;
  RxString error = ''.obs;

  Future<void> updateOrder({
    required String orderId,
    required String userId,
    required int price,
    required String menuId,
    required String status,
    required int refund,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${OrderApi.editStatusOrder}$orderId');
      var request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = userId
        ..fields['menuID'] = menuId
        ..fields['status'] = status
        ..fields['refund'] = refund.toString()
        ..fields['_method'] = 'put'
        ..headers['Accept'] = 'application/json';

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        isLoading.value = false;
        print('Order updated successfully');
        print('Response: ${response.body}');
        Get.back();
      } else {
        isLoading.value = false;
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
      isLoading.value = false;
      print('Error: $e');
      error.value = e.toString();

      Get.snackbar(
        'Error',
        'Failed to update order!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}