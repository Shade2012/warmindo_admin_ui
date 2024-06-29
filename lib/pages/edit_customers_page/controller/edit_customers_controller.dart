import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/pages/login_page/controller/login_controller.dart';

class EditCustomersController extends GetxController {
  RxBool isLoading = false.obs;
  String token = LoginController().getToken();
  
  Future updateCustomers({
    required String id,
    required String userVerified,
  }) async {
      try {
        isLoading.value = true;
        var uri = Uri.parse('${FoodApi.customers.updateCustomers}');
        var request = http.MultipartRequest('POST', uri)
          ..fields['id'] = id
          ..fields['userVerified'] = userVerified
          ..headers['Authorization'] = 'Bearer $token';

        var response = await http.Response.fromStream(await request.send());
        if (response.statusCode == 200) {
          isLoading.value = false;
          print('Customers updated successfully');
          print('Response: ${response.body}');
          Get.back();
        } else {
          isLoading.value = false;
          print('Failed to update customers: ${response.statusCode}');
          print('Response: ${response.body}');

          Get.snackbar('Error', 'Gagal mengupdate data pelanggan',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } catch (e) {
        isLoading.value = false;
        print('Error: $e');
        print(e.toString());
        Get.snackbar('Error', 'Gagal mengupdate data pelanggan',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } 
  }
