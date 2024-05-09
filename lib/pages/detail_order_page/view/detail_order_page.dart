import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/detail_order_bnb.dart';
import 'package:warmindo_admin_ui/pages/widget/receipt_widget.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                        Text('Id Pesanan', style: idOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0110),
                        Text('Tanggal Pesanan', style: dateOrderTextStyle),
                        SizedBox(height: screenHeight * 0.0125),
                        Text('Status Pesanan', style: statusOrderTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            ReceiptScreen(),
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: () {},
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
