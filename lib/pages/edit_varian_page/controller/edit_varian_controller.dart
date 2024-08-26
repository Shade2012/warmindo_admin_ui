import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class EditVariantController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString error = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> updateVarian({
    required String varianId,
    required String nameVarian,
    required String category,
    required int stock,
    File? image,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${VariantApi.updateVariant}$varianId?_method=PUT');
      var request = http.MultipartRequest('POST', uri)
        ..fields['name_varian'] = nameVarian
        ..fields['category'] = category
        ..fields['stock_varian'] = stock.toString()
        ..headers['Accept'] = 'application/json';

      if (image != null && image.path.isNotEmpty) {
        request.files.add(http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'varian_image.jpg',
        ));
      }

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        print('Varian updated successfully');
        print('Response: ${response.body}');
        // Update state lokal dengan data baru
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        isLoading.value = false;
        print('Failed to update varian: ${response.statusCode}');
        print('Response: ${response.body}');
        Get.snackbar(
          'Error',
          'Failed to update varian!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print('Error occurred while updating varian: $e');
      error.value = e.toString();
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    } else {
      Get.snackbar(
        'Warning',
        'Gambar tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
