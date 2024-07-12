import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/pages/order_page/widget/order_filter_dropdown.dart';

class OrderPage extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> selectedStatus = ValueNotifier<String>('Semua');

  List<Order> getFilteredOrders(
      List<Order> orders, String? selectedStatus, String searchTerm) {
    orders = getFilteredOrdersByStatus(orders, selectedStatus);
    return orders.where((order) {
      final customer = controller.getCustomerById(int.tryParse(order.userId) ?? 0);
      return customer?.name.toLowerCase().contains(searchTerm.toLowerCase()) ?? false;
    }).toList();
  }

  List<Order> getFilteredOrdersByStatus(
      List<Order> orders, String? selectedStatus) {
    if (selectedStatus == null || selectedStatus == 'Semua') {
      return orders;
    } else {
      return orders.where((order) => order.status == selectedStatus).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manajemen Pesanan',
          style: appBarTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    // Memperbarui tampilan daftar pesanan berdasarkan pencarian
                    // (Penggunaan setState tidak diperlukan karena build method tidak mengubah state)
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari nama pelanggan',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              OrderFilterDropdown(
                orders: controller.orderList,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                selectedStatus: selectedStatus,
                onChanged: (String? newValue) {
                  selectedStatus.value =
                      newValue ?? 'Semua'; // Update selectedStatus
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              // Menampilkan daftar pesanan sesuai filter atau pesan kosong
              ValueListenableBuilder<String>(
                valueListenable: selectedStatus,
                builder: (context, selectedValue, child) {
                  final filteredOrders = getFilteredOrders(
                      controller.orderList, selectedValue, searchController.text);

                  if (filteredOrders.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada pesanan yang tersedia.',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }

                  return Column(
                    children: filteredOrders.map((order) {
                      final customer = controller.getCustomerById(int.tryParse(order.userId) ?? 0);
                      return Column(
                        children: [
                          OrderBox(
                            order: order,
                            customerName: customer?.name ?? 'Unknown Customer',
                          ),
                          SizedBox(height: 10), // Add SizedBox with height 10
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
