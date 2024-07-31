import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/history_detail_page/view/detail_history_page.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/controller/history_controller.dart';
import 'package:warmindo_admin_ui/global/model/model_history_order.dart';

class OrderStatusWidget extends StatelessWidget {
  final List<Order> orders;
  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.orders,
  }) : super(key: key);
  final String status;
  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'sedang diproses':
        return ColorResources.labelinprogg;
      case 'menunggu batal':
      case 'batal':
        return ColorResources.labelcancel;
      case 'pesanan siap':
        return ColorResources.labelcomplete;
      default:
        return Colors.black;
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final HistoryController controller = Get.find();
    final labelColor = _getLabelColor(status);
    int totalOrders = orders.where((o) => o.status.toLowerCase() == status.toLowerCase()).length;

    return GestureDetector(
      onTap: (){
        Get.to(() => DetailHistoryPage(status: status, orders: controller.getOrdersByStatus(status)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.24,
              height: screenHeight * 0.11,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                child: Image.asset(controller.leadingImageChange(status)),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status, style: boldTextStyle.copyWith(color: labelColor, fontSize: 16)),
                SizedBox(height: screenHeight * 0.052),
                Text('Total Pesanan : $totalOrders', style: boldTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
