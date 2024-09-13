import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/controller/edit_order_controller.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';

class DetailOrderBnb extends StatelessWidget {
  DetailOrderBnb({Key? key, required this.order});
  final Order order;
  final OrderController controller = Get.find<OrderController>();
  final EditOrderController editOrderController =
      Get.put(EditOrderController());

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
        .where((o) => o.id == order.id)
        .map((o) => controller.customersList
            .firstWhere((customer) => customer.id == int.parse(o.userId)))
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
              width: 110,
              height: 65,
              child: Row(
                children: [
                  Visibility(
                    visible: order.status != 'menunggu pengembalian dana',
                    child: Container(
                      width: 60,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ReusableDialog(
                                title: "Konfirmasi",
                                content: "Apakah Kamu yakin ingin membatalkan pesanan ini?",
                                cancelText: "Tidak",
                                confirmText: "Iya",
                                onCancelPressed: () {
                                  Get.back();
                                },
                                onConfirmPressed: () {
                                  editOrderController.updateCancelOrder(order.id);
                                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                                },
                                cancelButtonColor:
                                    ColorResources.primaryColorLight,
                                confirmButtonColor: ColorResources.buttondelete,
                                dialogImage: Image.asset(Images.askDialog),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit,
                      color: Colors.white
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.EDIT_ORDER_PAGE, arguments: order);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
