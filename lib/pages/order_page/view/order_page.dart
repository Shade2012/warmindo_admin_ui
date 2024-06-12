import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/widget/orderBox.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class OrderPage extends StatelessWidget {
  final List<Order> orders = [
    order001,
    order002,
    // Tambahkan daftar pesanan lainnya di sini
  ];

  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> selectedStatus = ValueNotifier<String>('All');

  List<Order> getFilteredOrders(List<Order> orders, String? selectedStatus, String searchTerm) {
    orders = getFilteredOrdersByStatus(orders, selectedStatus);
    return orders.where((order) => order.nameCustomer.toLowerCase().contains(searchTerm.toLowerCase())).toList();
  }

  List<Order> getFilteredOrdersByStatus(List<Order> orders, String? selectedStatus) {
    if (selectedStatus == null || selectedStatus == 'All') {
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
                orders: orders,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                selectedStatus: selectedStatus,
                onChanged: (String? newValue) {
                  selectedStatus.value = newValue ?? 'All'; // Update selectedStatus
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              // Menampilkan daftar pesanan sesuai filter atau pesan kosong
              ValueListenableBuilder<String>(
                valueListenable: selectedStatus,
                builder: (context, selectedValue, child) {
                  return getFilteredOrders(orders, selectedValue, searchController.text).isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada pesanan yang tersedia.',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        )
                      : Column(
                          children: getFilteredOrders(orders, selectedValue, searchController.text).map((order) {
                            return Column(
                              children: [
                                OrderBox(
                                  order: order,
                                  nameCustomer: order.nameCustomer,
                                ),
                                SizedBox(height: screenHeight * 0.01),
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

class OrderFilterDropdown extends StatelessWidget {
  final List<Order> orders;
  final double screenHeight;
  final double screenWidth;
  final ValueNotifier<String> selectedStatus;
  final ValueChanged<String?>? onChanged;

  const OrderFilterDropdown({
    Key? key,
    required this.orders,
    required this.screenHeight,
    required this.screenWidth,
    required this.selectedStatus,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectedStatus.value,
          onChanged: onChanged,
          items: <String>[
            'All',
            'Dalam Proses',
            'Pesanan Siap',
            'Selesai',
            'Menunggu Batal',
            'Batal'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                height: screenHeight * 0.056,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: 'Semua Pesanan',
            hintStyle: filterTextStyle,
            fillColor: Colors.red,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
          ),
          dropdownColor: Colors.black, // Warna latar belakang dropdown
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white, // Warna ikon putih
          ),
        ),
      ],
    );
  }
}
