import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class EditToppingController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString error = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> updateStatusTopping({required String id, required bool statusTopping}) async {
    isLoading.value = true;
    final String endpoint = statusTopping
        ? ToppingsApi.enableTopping + id
        : ToppingsApi.disableTopping + id;
    print('Sending request to URL: $endpoint with user_verified: $statusTopping');

    final response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    isLoading.value = false;
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 && response.statusCode == 400) {
      print('User updated successfully');
      Get.snackbar(
        'Berhasil',
        'Status Topping Berhasil Diubah',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      print('Gagal mengubah status topping');
    }
  }

  Future<void> enabledStatus(String id) async {
    await updateStatusTopping(id: id, statusTopping: true);
  }

  Future<void> disabledStatus(String id) async {
    await updateStatusTopping(id: id, statusTopping: false);
  }

  Future<void> updateTopping({
    required String toppingId,
    required String nameTopping,
    required double price,
    required String stock,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${ToppingsApi.updateToppings}$toppingId?_method=PUT');
      var request = http.MultipartRequest('POST', uri)
        ..fields['name_topping'] = nameTopping
        ..fields['price'] = price.toString()
        ..fields['stock_topping'] = stock.toString()
        ..headers['Accept'] = 'application/json';

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        // Successfully updated the topping
        isLoading.value = false;
        print('Topping updated successfully');
        print('Response: ${response.body}');

        Get.offAllNamed(Routes.BOTTOM_NAVIGATION); // Navigate to desired page after update
      } else {
        // Error occurred
        isLoading.value = false;
        print('Failed to update topping: ${response.statusCode}');
        print('Response: ${response.body}');

        // Show error snackbar
        Get.snackbar(
          'Error',
          'Failed to update topping!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle error
      isLoading.value = false;
      print('Error occurred while updating topping: $e');
      error.value = e.toString();
      // Show error snackbar
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
