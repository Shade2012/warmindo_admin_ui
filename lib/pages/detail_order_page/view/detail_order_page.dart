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
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final adminFee =
        order.adminFee != null ? double.parse(order.adminFee ?? '') : 0;

    // Calculate total price using OrderDetails, including toppings
    double totalPrice = order.orderDetails.fold(0, (sum, detail) {
      // Menghitung harga item
      double itemPrice = double.parse(detail.menu.price) * detail.quantity;

      // Menghitung harga topping dan menjumlahkannya
      double toppingPrice = detail.toppings!.fold(0, (toppingSum, topping) {
        return toppingSum +
            (double.parse(topping.price.toString()) * detail.quantity);
      });

      return sum + itemPrice + toppingPrice;
    });

    final totalPayment = totalPrice;

    final labelColor = _getLabelColor(order.status);
    final formattedDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(order.createdAt.toString()));

    // Find customer data related to the order
    final customerData = controller.getCustomerById(int.parse(order.userId));

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
        title: Text('Detail Pesanan'),
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
                        Text('Warmindo Anggrek Muria',
                            style: nameRestoTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text('#ID ${order.id}', style: idOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text(formattedDate, style: dateOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0125),
                        Text(order.status,
                            style: statusOrderTextStyle.copyWith(
                                color: labelColor)),
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
                ...order.orderDetails
                    .map((detail) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(detail.menu.nameMenu,
                                      style: receiptcontentTextStyle),
                                  SizedBox(width: 9),
                                  Text(detail.quantity.toString(),
                                      style: receiptcontentTextStyle),
                                  Text(
                                      currencyFormat.format(
                                          double.parse(detail.menu.price) *
                                              detail.quantity),
                                      style: receiptcontentTextStyle),
                                ],
                              ),
                              if (detail.variant != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Varian: ${detail.variant!.nameVarian}',
                                    style: receiptcontentTextStyle.copyWith(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              if (detail.toppings != null &&
                                  detail.toppings!.isNotEmpty)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Topping:',
                                          style: receiptcontentTextStyle),
                                      ...detail.toppings!
                                          .map((topping) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '- ${topping.nameTopping} (${currencyFormat.format(double.parse(topping.price.toString()))})',
                                                      style: receiptcontentTextStyle
                                                          .copyWith(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ))
                    .toList(),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text('Detail Pembayaran', style: receiptheaderTextStyle),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Harga', style: receiptcontentTextStyle),
                    Text(currencyFormat.format(totalPrice),
                        style: receiptcontentTextStyle),
                  ],
                ),
                // SizedBox(height: 8.0),
                // if (adminFee > 0)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('Biaya Admin', style: receiptcontentTextStyle),
                //       Text(currencyFormat.format(adminFee),
                //           style: receiptcontentTextStyle),
                //     ],
                //   ),
                SizedBox(height: adminFee > 0 ? 8.0 : 0.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Metode Pembayaran', style: receiptcontentTextStyle),
                    Text(order.paymentMethod!, style: receiptcontentTextStyle),
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
                    Text(currencyFormat.format(totalPayment),
                        style: receiptcontentTextStyle),
                  ],
                ),
                SizedBox(height: 16.0),
                Divider(),
                Text('Detail Pelanggan', style: receiptheaderTextStyle),
                SizedBox(height: 16.0),
                if (customerData != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama Pelanggan', style: receiptcontentTextStyle),
                      Text(customerData.name, style: receiptcontentTextStyle),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email', style: receiptcontentTextStyle),
                      Text(customerData.email, style: receiptcontentTextStyle),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No. Telepon', style: receiptcontentTextStyle),
                      Text(customerData.phoneNumber,
                          style: receiptcontentTextStyle),
                    ],
                  ),
                ] else ...[
                  Text('Pelanggan tidak ditemukan',
                      style: receiptcontentTextStyle),
                ],
                // Display Return Method and Account Number if the status is "batal" or "menunggu batal"
                if (order.status.toLowerCase() == 'batal' ||
                    order.status.toLowerCase() == 'menunggu batal') ...[
                  SizedBox(height: 16.0),
                  Divider(),
                  SizedBox(height: 16.0),
                  Text('Metode Pengembalian', style: receiptheaderTextStyle),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Metode:', style: receiptcontentTextStyle),
                      Text(order.cancelMethod ?? '-',style: receiptcontentTextStyle),
                    ],
                  ),
                ],
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            // Notes Section
            if (order.note != null && order.note!.isNotEmpty) ...[
              Divider(),
              SizedBox(height: 16.0),
              Text('Catatan', style: receiptheaderTextStyle),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: ColorResources.primaryColorLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorResources.primaryColorDark),
                ),
                child: Text(order.note!, style: receiptcontentTextStyle),
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
            ElevatedButton(
              onPressed: () async {
                final pdfFile = await generateOrderPdf(order);
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => pdfFile);
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
