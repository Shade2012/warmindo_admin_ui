import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/model/model_customers.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';
import 'package:http/http.dart' as http;

import '../../../global/services/location_service.dart';

class OrderController extends GetxController {
  LocationService locationService = LocationService();
  var orderList = <Order>[].obs;
  var menuList = <Menu>[].obs;
  var customersList = <CustomerData>[].obs;
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longtitude = 0.0.obs;
  final InternetService _internetService = InternetService();

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
  Future<void> checkUserWithinRadar (BuildContext context) async{
    try{
      Position position = await locationService.getCurrentPosition();
      latitude.value = position.latitude;
      longtitude.value = position.longitude;
    }catch(e){
      if (e.toString().contains('permanently denied')) {
        // Show an alert dialog to guide the user to app settings
        showSettingsDialog(context);
      }
      Get.snackbar('Pesan', '$e');
    }
  }
  void showSettingsDialog(BuildContext context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Permission Required'),
        content: Text('Izin lokasi dilarang, silahkan pergi ke setting dan pilih enable '),
        actions: [
          TextButton(onPressed: () {
            locationService.openAppSettings();
            Get.back(closeOverlays: true);
          }, child: Text('Buka Settings')),
          TextButton(onPressed: () {
            Get.back(closeOverlays: true);
          }, child: Text('Nanti')),
        ],
      );
    },);
  }
  Future<void> _checkInternetConnection() async {
    isConnected.value = await _internetService.isConnected;
    if (isConnected.value) {
      await fetchDataMenu();
      await fetchDataCustomer();
      await fetchDataOrder();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchDataMenu() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getallProductList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData['menu'] is List) {
          final List<dynamic> allProductListData = responseData['menu'];
          menuList.value =
              allProductListData.map((json) => Menu.fromJson(json)).toList();
          print('Fetched Menu List: ${menuList.length}');
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data menu');
    }
  }

  Future<void> fetchDataCustomer() async {
    try {
      final response = await http.get(Uri.parse(AllCustomers().customers));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData is List) {
          final List<dynamic> customerListData = responseData;
          customersList.value = customerListData
              .map((json) => CustomerData.fromJson(json))
              .toList();
          print('Fetched Customer List: ${customersList.length}');
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print(response.statusCode);
        print('Gagal mengambil data pelanggan.');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> fetchDataOrder() async {
    try {
      final response = await http.get(Uri.parse(OrderApi.getallOrderList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['orders'];
        if (responseData != null && responseData is List) {
          final List<dynamic> orderListData = responseData;
          orderList.value = orderListData.map((json) => Order.fromJson(json)).toList();
          print('Fetched Order List: ${orderList.length}');
          isLoading.value = false;
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
          isLoading.value = false;
        }
      } else {
        print('Gagal mengambil data pesanan.');
        isLoading.value = false;
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      isLoading.value = false;
    }
  }

  CustomerData? getCustomerById(int id) {
    return customersList.firstWhereOrNull((customer) => customer.id == id);
  }

  Menu? getMenuById(int id) {
    return menuList.firstWhereOrNull((menu) => menu.id == id);
  }

  List<Order> getFilteredOrders(
      List<Order> orders, String? selectedStatus, String searchTerm) {
    // Filter orders based on status
    orders = getFilteredOrdersByStatus(orders, selectedStatus);

    // Filter out orders with specific statuses
    orders = orders.where((order) {
      final status = order.status.toLowerCase();
      return status != 'menunggu pembayaran' && status != 'menunggu batal';
    }).toList();

    // Sort orders by status priority
    orders.sort((a, b) {
      return compareOrderStatus(a.status?.toLowerCase(), b.status?.toLowerCase());
    });

    // Further filter based on search term
    orders = orders.where((order) {
      final customer = getCustomerById(int.tryParse(order.userId) ?? 0);
      return customer?.name.toLowerCase().contains(searchTerm.toLowerCase()) ?? false;
    }).toList();

    return orders;
  }

  List<Order> getFilteredOrdersByStatus(
      List<Order> orders, String? selectedStatus) {
    if (selectedStatus == null || selectedStatus == 'Semua') {
      return orders;
    } else {
      return orders.where((order) => order.status.toLowerCase() == selectedStatus.toLowerCase()).toList();
    }
  }

  int compareOrderStatus(String? statusA, String? statusB) {
    final statusOrder = {
      'sedang diproses': 1,
      'sedang diantar': 2,
      'selesai': 3,
      'batal': 4,
      'menunggu pengembalian dana': 5,
    };

    final priorityA = statusOrder[statusA] ?? 5;
    final priorityB = statusOrder[statusB] ?? 5;

    return priorityA.compareTo(priorityB);
  }

   int getOrderCountByStatus(String status) {
    return orderList.where((order) => order.status.toLowerCase() == status.toLowerCase()).length;
  }
}
