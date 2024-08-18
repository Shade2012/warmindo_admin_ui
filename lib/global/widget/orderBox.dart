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

  Color _getLabelColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'pesanan siap':
        return ColorResources.labelcomplete;
      case 'sedang diproses':
        return ColorResources.labelinprogg;
      case 'permintaan pembatalan':
        return ColorResources.labelcancel;
      case 'dibatalkan':
        return ColorResources.labelcancel;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Abaikan pesanan dengan status "menunggu pembayaran"
    if (order.status?.toLowerCase() == 'menunggu pembayaran') {
      return SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final labelColor = _getLabelColor(order.status);
    final borderColor = _getLabelColor(order.status);

    // Find order details related to the order
    final orderDetails = order.orderDetails;

    double totalPrice = 0;
    for (var detail in orderDetails) {
      double itemPrice = double.tryParse(detail.menu.price) ?? 0.0;

      // Menghitung harga topping dan menambahkannya ke total
      double toppingPrice = detail.toppings!.fold(0.0, (sum, topping) {
        return sum + (double.tryParse(topping.price.toString()) ?? 0.0) * (detail.quantity ?? 0);
      });

      totalPrice += (itemPrice * (detail.quantity ?? 0)) + toppingPrice;
    }

    // Tambahkan admin fee sebesar 1000
    double totalPriceWithAdminFee = totalPrice + 1000;

    String formattedPrice = totalPriceWithAdminFee.toStringAsFixed(
      totalPriceWithAdminFee.truncateToDouble() == totalPriceWithAdminFee ? 0 : 2,
    );

    return GestureDetector(
      onTap: () {
        if (order.status?.toLowerCase() == 'permintaan pembatalan') {
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
                Text('#ID ${order.id}', style: idOrderBoxTextStyle),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: labelColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(order.status ?? 'Status tidak tersedia', style: labelOrderBoxTextStyle),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: orderDetails.length,
                itemBuilder: (context, index) {
                  final detail = orderDetails[index];
                  double price = double.tryParse(detail.menu.price) ?? 0.0;

                  // Menghitung harga topping
                  double toppingPrice = detail.toppings!.fold(0.0, (sum, topping) {
                    return sum + (double.tryParse(topping.price.toString()) ?? 0.0) * (detail.quantity ?? 0);
                  });

                  double itemTotalPrice = (price * (detail.quantity ?? 0)) + toppingPrice;
                  String formattedItemPrice = itemTotalPrice.toStringAsFixed(
                    itemTotalPrice.truncateToDouble() == itemTotalPrice ? 0 : 2,
                  );
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          detail.menu.image,
                          width: 55.0,
                          height: 55.0,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(detail.menu.nameMenu ?? 'Nama Menu tidak tersedia', style: titleMenuOrderTextStyle),
                            SizedBox(height: 4.0),
                            Text('Rp $formattedItemPrice', style: priceMenuOrderTextStyle),
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
