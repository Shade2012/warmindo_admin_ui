import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/controller/cancel_order_controller.dart'; // Import DataController

class CancelOrderPage extends StatelessWidget {
  CancelOrderPage({Key? key}) : super(key: key);
  final CancelOrderController dataController = Get.put(CancelOrderController());

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Daftar pesanan
    final List<Order> orders = [
      order001,
      order002,
      order003,
      // Tambahkan daftar pesanan lainnya di sini
    ];

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
      body: Obx(() {
        if (!dataController.isConnected.value) {
          return Center(
            child: Text(
              'Tidak ada koneksi internet mohon cek internet anda',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: cancelOrders
                  .map(
                    (order) => Container(
                      height: screenHeight * 0.2,
                      width: screenWidth,
                      child: OrderBox(
                        order: order,
                        nameCustomer: order.nameCustomer,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }),
    );
  }
}
