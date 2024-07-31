import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/model/model_customers.dart';

class EditCustomersController extends GetxController {
  RxBool isLoading = false.obs;
  var allCustomerList = <CustomerData>[].obs;

  Future<void> updateCustomers({required String id, required bool userVerified}) async {
    isLoading.value = true;
    final String endpoint = userVerified
        ? AllCustomers().verifyCustomer + id + '/verify'
        : AllCustomers().unverifyCustomer + id + '/unverify';
    print('Sending request to URL: $endpoint with user_verified: $userVerified');
    
    final response = await http.put(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_verified': userVerified,
      }),
    );

    isLoading.value = false;

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 && response.statusCode == 400) {
      print('User updated successfully');
      Get.snackbar('Success', 'User status updated successfully',
          snackPosition: SnackPosition.TOP);
    } else {
      print('Failed to update user');
    }
  }

  Future<void> verifyUser(String userId) async {
    await updateCustomers(id: userId, userVerified: true);
  }

  Future<void> unverifyUser(String userId) async {
    await updateCustomers(id: userId, userVerified: false);
  }
}
