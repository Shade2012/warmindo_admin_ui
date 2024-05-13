import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/widget/orderBox.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? selectedStatus;

  List<Order> orders = [
    order001,
    order002,
    // Tambahkan daftar pesanan lainnya di sini
  ];

  List<Order> getFilteredOrders() {
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
          'Manage Orders',
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
              DropdownButtonFormField<String>(
                value: selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
                items: <String>[
                  'All',
                  'In Progress',
                  'Pesanan Siap',
                  'Done',
                  'Menunggu Batal',
                  'Cancel',
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
                  hintText: 'Filter by status',
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
              SizedBox(height: screenHeight * 0.02),
              // Menampilkan daftar pesanan sesuai filter
              Column(
                children: getFilteredOrders().map((order) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
