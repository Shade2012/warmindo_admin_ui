import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:http/http.dart' as http;

class AddVarianController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();
  final ProductController productController = Get.put(ProductController());

  Future<void> addVariants({
    File? image,
    required String nameVariant,
    required String category,
    required int stock,
  }) async {
    if (nameVariant.isEmpty || nameVariant.length > 255 || category.isEmpty || stock <= 0) {
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
        var request = http.MultipartRequest('POST', Uri.parse(VariantApi.storeVariant))
          ..fields['name_varian'] = nameVariant 
          ..fields['category'] = category.toString()
          ..fields['stock_varian'] = stock.toString();
        if (selectedImage.value != null) {
          File image = selectedImage.value!;
          request.files.add(http.MultipartFile(
            'image',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: 'variant_image.jpg',
          ));
        }

        var response = await http.Response.fromStream(await request.send());
        isLoading.value = false;
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Variants added successfully');
          print('Response: ${response.body}');
          Get.back();
          Get.back();
          productController.fetchAllData();
        } else {
          print('Failed to add variants');
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
