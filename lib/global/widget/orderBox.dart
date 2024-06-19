import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/view/detail_order_page.dart';
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/widget/dialog_cancel_order.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({
    Key? key,
    required this.order,
    required this.nameCustomer,
  }) : super(key: key);

  final Order order;
  final String nameCustomer;

  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'dalam Proses':
        return ColorResources.labelinprogg;
      case 'permintaan pembatalan':
        return ColorResources.labelcancel;
      case 'batal':
        return ColorResources.labelcancel;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = _getLabelColor(order.status);
    final borderColor = _getLabelColor(order.status);

    double totalPrice = 0;
    for (var menu in order.menus) {
      totalPrice += menu.price;
    }

    String formattedPrice = totalPrice.toStringAsFixed(
      totalPrice.truncateToDouble() == totalPrice ? 0 : 2,
    );

    return GestureDetector(
      onTap: () {
        if (order.status.toLowerCase() == 'permintaan pembatalan') {
          // Tampilkan dialog di sini
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogCancelOrder(
                title: 'Alasan: ${order.reason}',
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
                  Navigator.pop(context);
                },
                onConfirmPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        } else {
          Get.to(DetailOrderPage(order: order));
        }
      },
      child: Container(
        width: 395,
        height: 160,
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
                Text('${order.id}', style: idOrderBoxTextStyle),
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
                itemCount: order.menus.length,
                itemBuilder: (context, index) {
                  final menu = order.menus[index];
                  String formattedItemPrice = menu.price.toStringAsFixed(
                    menu.price.truncateToDouble() == menu.price ? 0 : 2,
                  );
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          menu.imagePath,
                          width: 40.0,
                          height: 40.0,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(menu.name, style: titleMenuOrderTextStyle),
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
                  nameCustomer,
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
