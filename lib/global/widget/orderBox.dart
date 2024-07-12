import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/view/detail_order_page.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/widget/dialog_cancel_order.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';

class OrderBox extends StatelessWidget {
  OrderBox({
    Key? key,
    required this.order,
    required this.customerName,
  }) : super(key: key);

  final Order order;
  final String customerName;
  final OrderController controller = Get.find<OrderController>();

  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'done':
        return ColorResources.labelcomplete;
      case 'ready':
        return ColorResources.labelcomplete;
      case 'in progress':
        return ColorResources.labelinprogg;
      case 'cancellation request':
        return ColorResources.labelcancel;
      case 'cancelled':
        return ColorResources.labelcancel;
      default:
        return Colors.black;
    }
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'done':
        return 'Selesai';
      case 'ready':
        return 'Pesanan Siap';
      case 'in progress':
        return 'Sedang Diproses';
      case 'cancellation request':
        return 'Permintaan Pembatalan';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final labelColor = _getLabelColor(order.status);
    final borderColor = _getLabelColor(order.status);
    final translatedStatus = _translateStatus(order.status);

    // Find menu items related to the order
    final menuItems = controller.orderList
        .where((o) => o.orderId == order.orderId)
        .map((o) => controller.menuList
            .firstWhere((menu) => menu.menuId == int.parse(o.menuId)))
        .toList();

    double totalPrice = 0;
    for (var menu in menuItems) {
      totalPrice += double.parse(menu.price);
    }

     // Tambahkan admin fee sebesar 1000
    double totalPriceWithAdminFee = totalPrice + 1000;

    String formattedPrice = totalPriceWithAdminFee.toStringAsFixed(
      totalPriceWithAdminFee.truncateToDouble() == totalPriceWithAdminFee ? 0 : 2,
    );

    return GestureDetector(
      onTap: () {
        if (order.status.toLowerCase() == 'cancellation request') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogCancelOrder(
                title: 'Alasan: -',
                content:
                    'Jika Anda membatalkan order ini maka uang akan dikembalikan ke user',
                cancelText: 'Tidak',
                confirmText: 'Ya',
                dialogImage: Image.asset(Images.cancelDialog),
                cancelButtonColor: Colors.white,
                confirmButtonColor: ColorResources.buttondelete,
                cancelButtonTextColor: Colors.black,
                confirmButtonTextColor: Colors.white,
                onCancelPressed: () {
                  Get.back();
                },
                onConfirmPressed: () {
                  Get.back();
                },
              );
            },
          );
        } else {
          Get.to(DetailOrderPage(order: order));
        }
      },
      child: Container(
        width: screenWidth * 1.4,
        height: screenHeight * 0.20,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: ColorResources.orderBox,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: borderColor, width: 2),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#ID ${order.orderId}', style: idOrderBoxTextStyle),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: labelColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(translatedStatus, style: labelOrderBoxTextStyle),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final menu = menuItems[index];
                  double price = double.parse(menuItems[index].price);
                  String formattedItemPrice = price.toStringAsFixed(
                    price.truncateToDouble() == price ? 0 : 2,
                  );
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          menu.image,
                          width: 55.0,
                          height: 55.0,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(menu.nameMenu, style: titleMenuOrderTextStyle),
                            SizedBox(height: 4.0),
                            Text('Rp $formattedItemPrice',
                                style: priceMenuOrderTextStyle),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  customerName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Rp $formattedPrice',
                  style: viewAllTextStyle2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
