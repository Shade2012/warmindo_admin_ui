import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class AddToppingController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> addToppings({
    required String nameTopping,
    required double price,
    required int stock,
    required int menu_id

  }) async {
    if (nameTopping.isEmpty || nameTopping.length > 255 || price <= 0 || stock <= 0) {
      Get.snackbar(
        'Warning',
        'Semua data harus diisi dan valid',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } else {
      try {
        isLoading.value = true;
        var request = http.MultipartRequest('POST', Uri.parse(ToppingsApi.storeToppings))
          ..fields['name_topping'] = nameTopping 
          ..fields['price'] = price.toString()
          ..fields['stock_topping'] = stock.toString()
          ..fields['menu_id'] = menu_id.toString();

        var response = await http.Response.fromStream(await request.send());
        isLoading.value = false;
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Toppings added successfully');
          print('Response: ${response.body}');
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        } else {
          print('Failed to add toppings');
          print('Response: ${response.body}');
        }
      } catch (e) {
        isLoading.value = false;
        print('Error: $e');
      }
    }
  }
}
