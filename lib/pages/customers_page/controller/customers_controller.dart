import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';
import 'package:warmindo_admin_ui/global/model/model_customers.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;

class CustomersController extends GetxController {
  var allCustomerList = <CustomerData>[].obs;
  var searchResults = <CustomerData>[].obs;
  RxBool isLoading = true.obs;
  RxString userVerified = ''.obs;
  RxBool isConnected = true.obs;
  final InternetService _internetService = InternetService();
  Timer? timer;

  @override
  void onInit() {
    _internetService.connectionChange.listen(_updateConnectionStatus);
    _checkInternetConnection();
    super.onInit();
  }

  void _updateConnectionStatus(bool connected) {
    isConnected.value = connected;
    if (!isConnected.value) {
      isLoading.value = false;
    }
  }

  Future<void> _checkInternetConnection() async {
    isConnected.value = await _internetService.isConnected;
    if (isConnected.value) {
      fetchDataCustomer();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchDataCustomer() async {
    try {
      final response = await http.get(Uri.parse(AllCustomers().customers));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        final responseDatauser2 = json.decode(response.body)['data'][1]['user_verified'];
        userVerified.value = responseDatauser2;
        if (responseData != null && responseData is List) {
          final List<dynamic> allCustomerListData = responseData;
          allCustomerList.value = allCustomerListData
              .map((json) => CustomerData.fromJson(json))
              .toList();
          searchResults.value = allCustomerList;
          print('{userVerified.value}');
          print(responseData);
          isLoading.value = false;
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data user');
    }
  }

  void searchCustomers(String query) {
    if (query.isEmpty) {
      searchResults.value = allCustomerList;
    } else {
      searchResults.value = allCustomerList
          .where((customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
