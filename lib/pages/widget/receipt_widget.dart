import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/model/modelorder.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class ReceiptScreen extends StatelessWidget {
  final Order order;

  ReceiptScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    double totalPrice = order.menus.fold(0, (sum, menu) => sum + menu.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesanan',
              style: receiptheaderTextStyle,
            ),
            SizedBox(height: 16.0),
            ...order.menus.map((menu) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(menu.name, style: receiptcontentTextStyle),
                  Text('1', style: receiptcontentTextStyle),
                ],
              ),
            )).toList(),
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
                Text('Price', style: receiptcontentTextStyle),
                Text('Rp $totalPrice', style: receiptcontentTextStyle),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Admin Fee', style: receiptcontentTextStyle),
                Text('Rp 1.000', style: receiptcontentTextStyle),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount', style: receiptcontentTextStyle),
                Text('Rp 5.000', style: receiptcontentTextStyle),
              ],
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: receiptcontentTextStyle),
                Text('Rp ${totalPrice + 1000 - 5000}', style: receiptcontentTextStyle),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pay Using ${order.paymentMethod}', style: receiptcontentTextStyle),
                Text('Rp ${totalPrice + 1000 - 5000}', style: receiptcontentTextStyle),
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
                Text('Customer', style: receiptcontentTextStyle),
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
                Text(order.phoneNumber ?? '-', style: receiptcontentTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
