import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/controller/cancel_order_controller.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart'; // Import DataController

class CancelOrderPage extends StatelessWidget {
  CancelOrderPage({Key? key}) : super(key: key);
  final CancelOrderController dataController = Get.put(CancelOrderController());
  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Filter pesanan dengan status permintaan pembatalan
    List<Order> cancelOrders = controller.orderList
        .where((order) => order.status == 'menunggu batal')
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
        if (cancelOrders.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada pesanan dengan permintaan pembatalan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
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
                    (order) => Column(
                      children: [
                        Container(
                          height: screenHeight * 0.2,
                          width: screenWidth,
                          child: OrderBox(
                            order: order,
                            customerName: controller.getCustomerById(int.tryParse(order.userId) ?? 0)?.name ?? '',
                          ),
                        ),
                        SizedBox(height: 8), // Add space between OrderBox widgets
                      ],
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
