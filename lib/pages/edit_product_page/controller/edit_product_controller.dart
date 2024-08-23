import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import '../../../routes/AppPages.dart';

class EditProductController extends GetxController {
  Rx<File> selectedImage = Rx<File>(File(''));
  RxString error = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> updateStatusMenu({required String id, required bool statusMenu}) async {
    isLoading.value = true;
    final String endpoint = statusMenu
        ? FoodApi.enableProduct + id 
        : FoodApi.disableProduct + id ;
    print('Sending request to URL: $endpoint with user_verified: $statusMenu');
    
    final response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    isLoading.value = false;
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 && response.statusCode == 400) {
      print('User updated successfully');
      Get.snackbar('Berhasil', 'Status Produk Berhasil Diubah',
          snackPosition: SnackPosition.TOP);
    } else {
      print('Gagal mengubah status produk');
    }
  }

  Future<void> enabledStatus(String id) async {
    await updateStatusMenu(id: id, statusMenu: true);
  }

  Future<void> disabledStatus(String id) async {
    await updateStatusMenu(id: id, statusMenu: false);
  }

  Future<void> updateProduct({
    String? menuId,
    String? nameMenu,
    int? price,
    String? category,
    String? stock,
    String? description,
    String? second_category,
    File? image,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${FoodApi.updateProduct}$menuId');
      var request = http.MultipartRequest('POST', uri)
        ..fields['name_menu'] = nameMenu ?? ''
        ..fields['price'] = price.toString()
        ..fields['category'] = category ??  ''
        ..fields['stock'] = stock.toString()
        ..fields['description'] = description ?? ''
        ..fields['second_category'] = second_category ?? ''
        ..fields['_method'] = 'put'
        ..headers['Accept'] = 'application/json';

      // Check if image is provided and the path is not empty
      if (image != null && image.path.isNotEmpty) {
        request.files.add(http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'product_image.jpg',
        ));
      }

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        // Successfully updated the product
        isLoading.value = false;
        print('Product updated successfully');
        print('Response: ${response.body}');

        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        // Error occurred
        isLoading.value = false;
        print('Failed to update product: ${response.statusCode}');
        print('Response: ${response.body}');

        // Show error snackbar
        Get.snackbar(
          'Error',
          'Failed to update product!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle error
      isLoading.value = false;
      print('Error occurred while updating product: $e');
      error.value = e.toString();
      // Show error snackbar
      Get.snackbar(
        'Error2',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path); // Store image as File
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Tidak ada gambar yang dipilih',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }
}
