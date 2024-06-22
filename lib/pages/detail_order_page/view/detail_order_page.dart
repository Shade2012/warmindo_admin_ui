import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/widget/detail_order_bnb.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/widget/pdf_generator.dart';

class DetailOrderPage extends StatelessWidget {
  final Order order;
  DetailOrderPage({required this.order});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double totalPrice = order.menus.fold(0, (sum, menu) => sum + menu.price);
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final adminFee = 1000;
    final discount = 5000;
    final totalPayment = totalPrice + adminFee - discount;

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
              height: screenHeight * 0.118,
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
                        Text('Warmindo Anggrek Muria',
                            style: nameRestoTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text(order.id, style: idOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text(order.dateOrder, style: dateOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0125),
                        Text(order.status, style: statusOrderTextStyle),
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
                Text(
                  'Pesanan',
                  style: receiptheaderTextStyle,
                ),
                SizedBox(height: 16.0),
                ...order.menus
                    .map((menu) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(menu.name, style: receiptcontentTextStyle),
                              Text('1', style: receiptcontentTextStyle),
                            ],
                          ),
                        ))
                    .toList(),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Detail Pembayaran',
                  style: receiptheaderTextStyle,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Harga', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(totalPrice),
                        style: receiptcontentTextStyle), // Corrected line
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Biaya Admin', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(adminFee),
                        style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Diskon', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(discount),
                        style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(totalPayment),
                        style: receiptcontentTextStyle), // Corrected line
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pembayaran ${order.paymentMethod}',
                        style: receiptcontentTextStyle),
                    Text(currencyFormat.format(totalPayment),
                        style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                Text(
                  'Detail Pelanggan',
                  style: receiptheaderTextStyle,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nama Pelanggan', style: receiptcontentTextStyle),
                    Text(order.nameCustomer, style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email', style: receiptcontentTextStyle),
                    Text(order.email ?? '-', style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No. Telepon', style: receiptcontentTextStyle),
                    Text(order.phoneNumber ?? '-',
                        style: receiptcontentTextStyle),
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
      bottomNavigationBar: DetailOrderBnb(),
    );
  }
}
