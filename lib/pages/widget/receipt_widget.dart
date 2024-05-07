import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesanan',
            style: receiptheaderTextStyle
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mie Ayam Bawang Rebus'),
              Text('1'),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Milo', style: receiptcontentTextStyle,),
              Text('1', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(),
          SizedBox(height: 16.0),
          Text(
            'Detail Pembayaran',
            style: receiptheaderTextStyle
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price', style: receiptcontentTextStyle,),
              Text('Rp 15.000' , style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Admin Fee' , style: receiptcontentTextStyle,),
              Text('Rp 1.000', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount', style: receiptcontentTextStyle,),
              Text('Rp 5.000', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: receiptcontentTextStyle,),
              Text('Rp 11.000', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pay Using OVO', style: receiptcontentTextStyle,),
              Text('Rp 11.000', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 16.0),
          Divider(),
          Text(
            'Detail Pelanggan',
            style: receiptheaderTextStyle
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Customer', style: receiptcontentTextStyle,),
              Text('Damar Fikri', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Email', style: receiptcontentTextStyle,),
              Text('damarfikri@gmail.com', style: receiptcontentTextStyle,),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('No. Telepon', style: receiptcontentTextStyle,),
              Text('+62 856 39026530', style: receiptcontentTextStyle,),
            ],
          ),
        ],
      ),
    );
  }
}
