import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/controller/history_controller.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/widget/history_order_status.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Riwayat Pesanan', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(
                () => ListView(
                  children: [
                    OrderStatusWidget(
                      status: 'Selesai',
                      orders: controller.filteredHistory(),
                    ),
                    OrderStatusWidget(
                      status: 'Sedang Diproses',
                      orders: controller.filteredHistory(),
                    ),
                    OrderStatusWidget(
                      status: 'Menunggu Batal',
                      orders: controller.filteredHistory(),
                    ),
                    OrderStatusWidget(
                      status: 'Batal',
                      orders: controller.filteredHistory(),
                    ),
                    OrderStatusWidget(
                      status: 'Pesanan Siap',
                      orders: controller.filteredHistory(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
