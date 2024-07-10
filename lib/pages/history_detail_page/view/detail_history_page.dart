import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/history_detail_page/controller/detail_history_controller.dart';
import 'package:warmindo_admin_ui/global/model/history_order_model.dart';

class DetailHistoryPage extends StatelessWidget {
  final DetailHistoryController controller = Get.put(DetailHistoryController());
  final List<Order> orders;
  DetailHistoryPage({super.key, required this.orders, required String status});

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
        title: Text(
          'Pesanan',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Data Kosong'),
      ),
    );
  }
}
