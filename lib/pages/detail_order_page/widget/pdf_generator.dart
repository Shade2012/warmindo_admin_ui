import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/widget/dashed_line.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';

Future<Uint8List> generateOrderPdf(Order order) async {
  final pdf = pw.Document();
  final controller = Get.put(OrderController());
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  // Calculate total price and prepare menu items
  double totalPrice = order.orderDetails.fold(0, (sum, orderDetail) {
    double itemPrice = double.parse(orderDetail.menu.price) * orderDetail.quantity;

    // Calculate total topping price for the current orderDetail
    double toppingPrice = orderDetail.toppings!.fold(0, (toppingSum, topping) {
      return toppingSum + topping.price * orderDetail.quantity;
    });

    return sum + itemPrice + toppingPrice;
  });

  final menuItems = <pw.Widget>[];

  for (var orderDetail in order.orderDetails) {
    final menu = orderDetail.menu;

    // Menu item
    menuItems.add(pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(menu.nameMenu, style: pw.TextStyle(fontSize: 16)),
        pw.Text(orderDetail.quantity.toString(), style: pw.TextStyle(fontSize: 16)),
        pw.Text(currencyFormat.format(double.parse(menu.price) * orderDetail.quantity),
            style: pw.TextStyle(fontSize: 16)),
      ],
    ));

    // Variant
    if (orderDetail.variant != null) {
      menuItems.add(pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text('- Variant: ${orderDetail.variant!.nameVarian}', style: pw.TextStyle(fontSize: 14)),
        ],
      ));
    }

    // Toppings
    if (orderDetail.toppings != null && orderDetail.toppings!.isNotEmpty) {
      for (var topping in orderDetail.toppings!) {
        menuItems.add(pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text('- Topping: ${topping.nameTopping} (${currencyFormat.format(topping.price * orderDetail.quantity)})',
                style: pw.TextStyle(fontSize: 14)),
          ],
        ));
      }
    }
  }

  final adminFee = double.parse(order.adminFee);
  final totalPayment = totalPrice + adminFee;

  // Load the logo image
  final ByteData bytes = await rootBundle.load('assets/images/logo.png');
  final Uint8List logo = bytes.buffer.asUint8List();

  // Access customer data using the userId from the order
  final customerData = controller.getCustomerById(int.parse(order.userId));

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Warmindo Anggrek Muria', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Jalan Raya Jurang Besito Kulon', style: pw.TextStyle(fontSize: 12)),
                    pw.Text('Besito, Gebog, Kabupaten Kudus, Jawa Tengah 59333', style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
                pw.Image(pw.MemoryImage(logo), width: 100), // Add the logo image
              ],
            ),
            pw.SizedBox(height: 10),
            DashedLine(
              dash: 3,
              gap: 2,
              width: 500,
              height: 1,
              color: PdfColors.black,
            ),
            pw.SizedBox(height: 16),
            pw.Text('Order ID: ${order.id}', style: pw.TextStyle(fontSize: 16)),
            pw.Text('Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(order.createdAt.toString()))}', style: pw.TextStyle(fontSize: 16)),
            pw.Text('Status: ${order.status}', style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 16),
            pw.Text('Pesanan', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...menuItems,
            pw.SizedBox(height: 16),
            pw.Divider(),
            pw.SizedBox(height: 16),
            pw.Text('Detail Pembayaran', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Harga', style: pw.TextStyle(fontSize: 16)),
                pw.Text(currencyFormat.format(totalPrice),
                    style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Biaya Admin', style: pw.TextStyle(fontSize: 16)),
                pw.Text(currencyFormat.format(adminFee), style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Metode Pembayaran', style: pw.TextStyle(fontSize: 16)),
                pw.Text(order.paymentMethod!, style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(),
            pw.SizedBox(height: 16),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.Text(currencyFormat.format(totalPayment),
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(),
            pw.SizedBox(height: 4),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text('Terima kasih atas pesanan Anda!', style: pw.TextStyle(fontSize: 16)),
            ),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text('Jangan lupa datang lagi yah!', style: pw.TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
