import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/model/model_topping.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

import '../widget/menu_selected_widget.dart';

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
  
  Future<void> postSelectedToppings( {
      required String nameTopping,
      required double price,
      required String statusTopping,
      required int stock,
    required List<int> menu_ids}) async {
    final response = await http.post(
      Uri.parse(ToppingsApi.storeToppings),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name_topping': nameTopping, // Replace with actual name if needed
        'stock_topping': stock, // Replace with actual stock if needed
        'status_topping': statusTopping, // Replace with actual status if needed
        'price': price, // Replace with actual price if needed
        'menu_ids': menu_ids,
      }),
    );

    if (response.statusCode == 201) {
      // Handle success
      print('success');
      Get.back();
      Get.back();
    } else {
      // Handle error
      print('Failed to add toppings');
      print('Response: ${response.body}');
      print('gagal');
    }
  }

  void showDetailPopupModal(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      elevation: 0,

      builder:(context) {

        return MenuSelected();
      },
    );

  }
}
