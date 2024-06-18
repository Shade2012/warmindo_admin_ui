import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';
import 'package:warmindo_admin_ui/global/model/customers.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:http/http.dart' as http;

class CustomersController extends GetxController {
  var allCustomerList = <CustomerData>[].obs;
  var searchResults = <CustomerData>[].obs;
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  final InternetService _internetService = InternetService();
  Timer? timer;

  @override
  void onInit() {
    _internetService.connectionChange.listen(_updateConnectionStatus);
    _checkInternetConnection();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (isConnected.value) {
        fetchDataCustomer();
      }
    });
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
        if (responseData != null && responseData is List) {
          final List<dynamic> allCustomerListData = responseData;
          allCustomerList.value = allCustomerListData
              .map((json) => CustomerData.fromJson(json))
              .toList();
          searchResults.value = allCustomerList;
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
      print('Selesai fetching data');
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
