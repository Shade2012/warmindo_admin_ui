import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';


class AddProductController extends GetxController {
  Rx<File> selectedImage = Rx<File>(File(''));
  RxBool isLoading = false.obs;
  final ProductController productController = Get.put(ProductController());

  Future<void> addProduct({
    required File image,
    required String nameMenu,
    required int price,
    required String category,
    required String secondCategory,
    required int stock,
    required double ratings,
    required String description,
  }) async {
    if (image.path.isEmpty  || nameMenu == null || nameMenu.isEmpty || price.isNaN || category == null || category.isEmpty || stock == null || ratings == null || description == null || description.isEmpty || secondCategory.isEmpty)  {
      Get.snackbar(
        'Warning',
        'Semua data harus diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

    }
    else {
      try {
        isLoading.value = true;
        var request = http.MultipartRequest('POST', Uri.parse(FoodApi.storeProduct))
          ..fields['name_menu'] = nameMenu
          ..fields['price'] = price.toString()
          ..fields['category'] = category
          ..fields['stock'] = stock.toString()
          ..fields['ratings'] = ratings.toString()
          ..fields['second_category'] = secondCategory
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
          Get.back();
          Get.back();
          productController.fetchAllData();
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
          '${e}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
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
