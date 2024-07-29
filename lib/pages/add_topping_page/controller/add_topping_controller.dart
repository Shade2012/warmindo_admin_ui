import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class AddToppingController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> addToppings({
    required File image,
    required String nameTopping,
    required double price,
    required int stock,
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
          ..fields['stock'] = stock.toString();
        
        if (selectedImage.value != null) {
          File image = selectedImage.value!;
          request.files.add(http.MultipartFile(
            'image',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: 'topping_image.jpg',
          ));
        }

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

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.snackbar(
          'Warning',
          'Gambar tidak ditemukan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }
}
