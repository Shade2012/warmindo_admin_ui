import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/widget/detail_order_bnb.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/widget/pdf_generator.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';

class DetailOrderPage extends StatelessWidget {
  final Order order;
  final OrderController controller = Get.put(OrderController());

  DetailOrderPage({required this.order});

  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'Selesai':
        return ColorResources.labelcomplete;
      case 'Pesanan Siap':
        return ColorResources.labelcomplete;
      case 'Sedang Diproses':
        return ColorResources.labelinprogg;
      case 'Permintaan Pembatalan':
        return ColorResources.labelcancel;
      case 'Dibatalkan':
        return ColorResources.labelcancel;
      default:
        return Colors.black;
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final adminFee = 1000;

    // Calculate total price
    double totalPrice = controller.orderList
        .where((o) => o.orderId == order.orderId)
        .fold(0, (sum, o) => sum + double.parse(o.priceOrder));

    final totalPayment = totalPrice + adminFee;

    // Find menu items related to the order
    final menuItems = controller.orderList
        .where((o) => o.orderId == order.orderId)
        .map((o) => controller.menuList.firstWhere((menu) => menu.menuId == int.parse(o.menuId)))
        .toList();

    // find customerdata related to the order
    final userData = controller.orderList
        .where((o) => o.orderId == order.orderId)
        .map((o) => controller.customersList.firstWhere((customer) => customer.id == int.parse(o.userId)))
        .toList();

    final labelColor = _getLabelColor(order.status);
    final formattedDate = DateFormat('dd-MM-yyyy').format(order.orderDate);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenHeight * 0.08,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(screenHeight * 0.025),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        title: Text('Detail Order'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenHeight * 0.02, vertical: screenHeight * 0.02),
        child: ListView(
          children: [
            Container(
              width: screenHeight * 0.86,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Images.splashLogo,
                    width: screenHeight * 0.120,
                  ),
                  SizedBox(width: screenHeight * 0.05),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Warmindo Anggrek Muria', style: nameRestoTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text(order.orderId.toString(), style: idOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text(formattedDate, style: dateOrderTextStyle), // Updated line
                        SizedBox(height: screenHeight * 0.0125),
                        Text(order.status, style: statusOrderTextStyle.copyWith(color: labelColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pesanan', style: receiptheaderTextStyle),
                SizedBox(height: 16.0),
                ...menuItems.map((menu) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(menu.nameMenu, style: receiptcontentTextStyle),
                      Text('1', style: receiptcontentTextStyle),
                      Text(currencyFormat.format(double.parse(menu.price)), style: receiptcontentTextStyle),
                    ],
                  ),
                )).toList(),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text('Detail Pembayaran', style: receiptheaderTextStyle),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Harga', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(totalPrice), style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Biaya Admin', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(adminFee), style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 8.0),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(totalPayment), style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                Text('Detail Pelanggan', style: receiptheaderTextStyle),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nama Pelanggan', style: receiptcontentTextStyle),
                    Text(userData[0].name, style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email', style: receiptcontentTextStyle),
                    Text(userData[0].email, style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No. Telepon', style: receiptcontentTextStyle),
                    Text(userData[0].phoneNumber, style: receiptcontentTextStyle),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: () async {
                final pdfFile = await generateOrderPdf(order);
                await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfFile);
              },
              child: Text('Cetak Bukti'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DetailOrderBnb(order: order),
    );
  }
}
