import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/widget/orderBox.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class CancelOrderPage extends StatefulWidget {
  CancelOrderPage({Key? key});

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  List<Order> orders = [
    order001,
    order002,
    order003,
  ];

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Filter pesanan dengan status permintaan pembatalan
    List<Order> cancelOrders = orders
        .where((order) => order.status == 'Permintaan Pembatalan')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembatalan Pesanan'),
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Mengatur widget berada di bagian atas
            children: cancelOrders
                .map(
                  (order) => Container(
                    height: screenHeight * 0.2, // Menggunakan 20% dari tinggi layar 
                    width: screenWidth, // Menggunakan lebar layar
                    child: OrderBox(
                      order: order,
                      nameCustomer: order.nameCustomer,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
