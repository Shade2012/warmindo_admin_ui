import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/model/modelorder.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: CustomAppBar().preferredSize,
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.02),
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
                    SizedBox(width: screenWidth * 0.56),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ORDER_PAGE);
                      },
                      child: Text(
                        'Lihat Semua',
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
                  SizedBox(height: screenHeight * 0.01),
                  OrderBox(
                    order: order002,
                    nameCustomer: 'Damar Fikri',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
