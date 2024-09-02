import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/controller/cancel_order_controller.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/view/detail_order_page.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/widget/dialog_cancel_order.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/controller/edit_order_controller.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class OrderBox extends StatelessWidget {
  OrderBox({
    Key? key,
    required this.order,
    required this.customerName,
  }) : super(key: key);

  final Order order;
  final String customerName;
  final OrderController controller = Get.find<OrderController>();
  final EditOrderController editOrderController = Get.put(EditOrderController());
  final CancelOrderController cancelOrderController = Get.put(CancelOrderController());

  Color _getLabelColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'pesanan siap':
        return ColorResources.labelcomplete;
      case 'sedang diproses':
        return ColorResources.labelinprogg;
      case 'menunggu batal':
        return ColorResources.labelcancel;
      case 'batal':
        return ColorResources.labelcancel;
      case 'menunggu pengembalian dana':
        return Colors.grey[600]!;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final labelColor = _getLabelColor(order.status);
    final borderColor = _getLabelColor(order.status);

    final orderDetails = order.orderDetails;

    double totalPrice = 0;
    for (var detail in orderDetails) {
      double itemPrice = double.tryParse(detail.menu.price) ?? 0.0;

      double toppingPrice = detail.toppings!.fold(0.0, (sum, topping) {
        return sum + (double.tryParse(topping.price.toString()) ?? 0.0) * (detail.quantity);
      });

      totalPrice += (itemPrice * (detail.quantity)) + toppingPrice;
    }

    // double totalPriceWithAdminFee = totalPrice + (order.adminFee != null ? double.tryParse(order.adminFee ?? '') ?? 0.0 : 0.0);

    String formattedPrice = totalPrice.toStringAsFixed(
      totalPrice.truncateToDouble() == totalPrice ? 0 : 2,
    );

    return GestureDetector(
      onTap: () {
        if (order.status.toLowerCase() == 'menunggu batal') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogCancelOrder(
                title: 'Alasan: ${order.reasonCancel}',
                content: 'Jika Anda membatalkan pesanan ini, anda harus mengembalikan uang pelanggan!',
                content2: 'Metode Pembatalan : ${order.cancelMethod}',
                cancelText: 'Tolak',
                confirmText: 'Terima',
                dialogImage: Image.asset(Images.cancelDialog),
                cancelButtonColor: Colors.white,
                confirmButtonColor: ColorResources.buttondelete,
                cancelButtonTextColor: Colors.black,
                confirmButtonTextColor: Colors.white,
                onCancelPressed: () {
                  cancelOrderController.rejectCancel(order.id);
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                },
                onConfirmPressed: () {
                  cancelOrderController.acceptCancel(order.id);
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
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
                  child: Text(order.status, style: labelOrderBoxTextStyle),
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

                  double toppingPrice = detail.toppings!.fold(0.0, (sum, topping) {
                    return sum + (double.tryParse(topping.price.toString()) ?? 0.0) * (detail.quantity);
                  });

                  double itemTotalPrice = (price * (detail.quantity)) + toppingPrice;
                  String formattedItemPrice = itemTotalPrice.toStringAsFixed(
                    itemTotalPrice.truncateToDouble() == itemTotalPrice ? 0 : 2,
                  );
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_ORDER_PAGE, arguments: order);
                          },
                          child: Image.network(
                            detail.menu.image,
                            width: 55.0,
                            height: 55.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_ORDER_PAGE, arguments: order);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(detail.menu.nameMenu, style: titleMenuOrderTextStyle),
                              SizedBox(height: 4.0),
                              Text('Rp $formattedItemPrice', style: priceMenuOrderTextStyle),
                            ],
                          ),
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
