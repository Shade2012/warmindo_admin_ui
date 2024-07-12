import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';


class DetailOrderBnb extends StatelessWidget {
  DetailOrderBnb({Key? key, required this.order});
  final Order order;
  final OrderController controller = Get.find<OrderController>();

  String convertPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      return '+62${phoneNumber.substring(1)}';
    }
    return phoneNumber;
  }

  Future<void> launchWhatsApp(String phoneNumber) async {
    final String url = 'https://wa.me/$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      SnackBar(content: Text('Tidak dapat membuka WhatsApp'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = controller.orderList
        .where((o) => o.orderId == order.orderId)
        .map((o) => controller.customersList.firstWhere((customer) => customer.id == int.parse(o.userId)))
        .toList();

    final String phoneNumber = convertPhoneNumber(userData[0].phoneNumber);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hubungi'),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    await launchWhatsApp(phoneNumber);
                  },
                  child: Container(
                    width: 30,
                    height: 40,
                    child: SvgPicture.asset(IconThemes.iconWhatsapp),
                  ),
                ),
              ],
            ),
            Container(
              width: 70,
              height: 65,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Get.toNamed(Routes.EDIT_ORDER_PAGE, arguments: order);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
