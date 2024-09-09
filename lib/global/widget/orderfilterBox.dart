import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/order_page/view/order_page.dart';

class OrderFilterBox extends StatelessWidget {
  const OrderFilterBox({
    Key? key,
    required this.totalOrders,
    required this.titleFilterBox,
    required this.imagePath,
    required this.filterStatus, // Tambahkan parameter untuk filter status
  }) : super(key: key);

  final int totalOrders;
  final String titleFilterBox;
  final String imagePath;
  final String filterStatus; // Status filter

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderPage(), arguments: filterStatus); // Kirim filter status ke halaman OrderPage
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ColorResources.analyticBoxColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(2.0, 5.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleFilterBox,
              style: headerAnalyticBoxTextStyle,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalOrders.toString(),
                  style: valueAnalyticBoxTextStyle,
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  imagePath,
                  width: 40.0,
                  height: 40.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
