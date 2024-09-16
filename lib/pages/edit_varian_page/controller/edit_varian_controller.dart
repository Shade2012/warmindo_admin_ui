import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';

class EditVariantController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<String> categoryList = <String>[].obs;
  RxString error = ''.obs;
  RxBool isLoading = false.obs;
  final ProductController productController = Get.put(ProductController());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    final response = await http.get(
      Uri.parse(VariantApi.getCategoryVariant),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body)['menu_name'];
      categoryList.addAll(List<String>.from(jsonData));
      print('category: $categoryList');
    } else {
      Get.snackbar('Error', 'Failed to fetch categories', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> updateStatusVariant({required String id, required bool statusVariant}) async {
    if (id == '0' || id.isEmpty) {
      print('Invalid ID detected: $id');
      Get.snackbar(
        'Error',
        'Invalid product ID',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final String endpoint = statusVariant
        ? VariantApi.enableVariant + id
        : VariantApi.disableVariant + id;
    print('Sending request to URL: $endpoint with statusVariant: $statusVariant');

    final response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    isLoading.value = false;
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Status varian berhasil diubah');
      Get.snackbar(
        'Berhasil',
        'Status Varian Berhasil Diubah',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      print('Gagal mengubah status varian');
      Get.snackbar(
        'Error',
        'Gagal mengubah status varian: ${response.body}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> enabledStatus(String idVarian) async {
    await updateStatusVariant(id: idVarian, statusVariant: true);
  }

  Future<void> disabledStatus(String idVarian) async {
    await updateStatusVariant(id: idVarian, statusVariant: false);
  }

  Future<void> updateVarian({
    required String varianId,
    required String nameVarian,
    required String category,
    required int stock,
    File? image,
  }) async {
    if (varianId == '0' || varianId.isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid varian ID',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

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
        isLoading.value = false;
        Get.back();
        Get.back();
        productController.fetchAllData();
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
