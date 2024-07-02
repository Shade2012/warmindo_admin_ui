import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/widget/dashed_line.dart';


Future<Uint8List> generateOrderPdf(Order order) async {
  final pdf = pw.Document();
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  double totalPrice = order.menus.fold(0.0, (sum, menu) => sum + menu.price);
  final adminFee = 1000.0;
  final discount = 5000.0;
  final totalPayment = totalPrice + adminFee - discount;

  final ByteData bytes = await rootBundle.load('assets/images/logo.png');
  final Uint8List logo = bytes.buffer.asUint8List();

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
            pw.SizedBox(height: 16),
            DashedLine(
              dash: 3,
              gap: 2,
              width: 500, // Explicitly set the width
              height: 1,
              color: PdfColors.black,
            ),
            pw.SizedBox(height: 16),
            pw.Text('Order ID: ${order.id}', style: pw.TextStyle(fontSize: 16)),
            pw.Text('Date: ${order.dateOrder}', style: pw.TextStyle(fontSize: 16)),
            pw.Text('Status: ${order.status}', style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 16),
            pw.Text('Pesanan', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ...order.menus.map((menu) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(menu.name, style: pw.TextStyle(fontSize: 16)),
                    pw.Text('1', style: pw.TextStyle(fontSize: 16)),
                  ],
                )),
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
                pw.Text('Diskon', style: pw.TextStyle(fontSize: 16)),
                pw.Text(currencyFormat.format(discount), style: pw.TextStyle(fontSize: 16)),
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
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Pembayaran ${order.paymentMethod}', style: pw.TextStyle(fontSize: 16)),
                pw.Text(currencyFormat.format(totalPayment),
                    style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(),
            pw.Text('Detail Pelanggan', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Nama Pelanggan', style: pw.TextStyle(fontSize: 16)),
                pw.Text(order.nameCustomer, style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Email', style: pw.TextStyle(fontSize: 16)),
                pw.Text(order.email ?? '-', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('No. Telepon', style: pw.TextStyle(fontSize: 16)),
                pw.Text(order.phoneNumber ?? '-', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
            pw.Spacer(), // Takes up the remaining space
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
