import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/repository/warmindo_repository.dart';

import '../../../routes/AppPages.dart';

class EditProductController extends GetxController {
  Rx<File> selectedImage = Rx<File>(File(''));
  RxBool isLoading = false.obs;

  Future<void> updateProduct({
    required String menuId,
    required String nameMenu,
    required int price,
    required String category,
    required int stock,
    required double ratings,
    required String description,
    File? image,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${FoodApi.updateProduct}/$menuId');
      var request = http.MultipartRequest('POST', uri)
        ..fields['name_menu'] = nameMenu
        ..fields['price'] = price.toString()
        ..fields['category'] = category
        ..fields['stock'] = stock.toString()
        ..fields['ratings'] = ratings.toString()
        ..fields['description'] = description;
      
      if (image != null) {
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

      // Show error snackbar
      Get.snackbar(
        'Error',
        'An error occurred while updating the product!',
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
