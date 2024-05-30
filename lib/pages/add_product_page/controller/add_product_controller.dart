import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/repository/warmindo_repository.dart';

class AddProductController extends GetxController {
  final TextEditingController ctrProductName = TextEditingController();
  final TextEditingController ctrProductPrice = TextEditingController();
  final TextEditingController ctrProductDesc = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxString('');

  Future<void> addMenu() async {
    try {
      String productName = ctrProductName.text.trim();
      String productPrice = ctrProductPrice.text.trim();
      String productDesc = ctrProductDesc.text.trim();
      String category = selectedCategory.value.trim();
      String stock = selectedStock.value.trim();

      // Validate inputs
      if (productName.isEmpty || productPrice.isEmpty || category.isEmpty || stock.isEmpty || productDesc.isEmpty) {
        Get.snackbar("Error", "Harap lengkapi semua kolom", snackPosition: SnackPosition.TOP);
        return;
      }

      Map<String, dynamic> newMenu = {
        'name_menu': productName,
        'price': double.parse(productPrice),
        'description': productDesc,
        'category': category,
        'stock': stock == 'Tersedia' ? 20 : 0,
        // Additional properties if needed
      };

      final response = await http.post(
        Uri.parse(FoodApi.addMenu),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newMenu),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Sukses', 'Produk berhasil ditambahkan', snackPosition: SnackPosition.TOP);
        clearFields();
      } else {
        Get.snackbar('Error', 'Failed to add menu: ${response.reasonPhrase}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Exception', 'Failed to add menu: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void clearFields() {
    ctrProductName.clear();
    ctrProductPrice.clear();
    ctrProductDesc.clear();
    selectedCategory.value = '';
    selectedStock.value = '';
  }

  @override
  void dispose() {
    ctrProductName.dispose();
    ctrProductPrice.dispose();
    ctrProductDesc.dispose();
    super.dispose();
  }
}
