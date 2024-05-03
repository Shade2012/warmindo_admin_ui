import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/home_page/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/pages/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/pages/widget/orderBox.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/icon_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: CustomAppBar().preferredSize,
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenWidth * 0.02),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: AnalyticBox(
                      totalSales: 200000,
                      titleAnalyticBox: 'Total Penjualan',
                      imagePath: IconThemes.iconCoin,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: AnalyticBox(
                      totalSales: 50,
                      titleAnalyticBox: 'Produk',
                      imagePath: IconThemes.iconProduct,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Row(
                children: [
                  Text(
                    'Pesanan',
                    style: subHeadOrderTextStyle,
                  ),
                  SizedBox(width: screenWidth * 0.54),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ORDER_PAGE);
                    },
                    child: Text(
                      'Lihat Semuanya',
                      style: viewAllTextStyle2,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                OrderBox(
                  order: order001,
                  nameCustomer: 'Baratha Wijaya',
                ),
                SizedBox(height: 10.0),
                OrderBox(
                  order: order002,
                  nameCustomer: 'Damar Fikri',
                ),
              ],
            ), // Menambahkan OrderBox ke dalam Column
          ],
        ),
      ),
    );
  }
}
