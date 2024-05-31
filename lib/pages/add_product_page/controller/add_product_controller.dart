import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/repository/warmindo_repository.dart';

import '../../../routes/AppPages.dart';

class AddProductController extends GetxController {
  Rx<File> selectedImage = Rx<File>(File(''));
  RxBool isLoading = false.obs;

  Future<void> addProduct({
    required File image,
    required String nameMenu,
    required int price,
    required String category,
    required int stock,
    required double ratings,
    required String description,
  }) async {
    if (image == null || nameMenu == null || nameMenu.isEmpty || price.isNaN || category == null || category.isEmpty || stock == null || ratings == null || description == null || description.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua data harus diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      var request = http.MultipartRequest('POST', Uri.parse(FoodApi.storeProduct))
        ..fields['name_menu'] = nameMenu
        ..fields['price'] = price.toString()
        ..fields['category'] = category
        ..fields['stock'] = stock.toString()
        ..fields['ratings'] = ratings.toString()
        ..fields['description'] = description
        ..files.add(http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'product_image.jpg',
        ));

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully added the product
        isLoading.value = false;
        print('Product added successfully');
        print('Response: ${response.body}');

        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      }
      else {
        // Error occurred
        isLoading.value = false;
        print('Failed to add product: ${response.statusCode}');
        print('Response: ${response.body}');

        // Show error snackbar
        Get.snackbar(
          'Error',
          'Failed to add product!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle error
      isLoading.value = false;
      print('Error occurred while adding product: $e');

      // Show error snackbar
      Get.snackbar(
        'Error',
        'An error occurred while adding the product!',
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
