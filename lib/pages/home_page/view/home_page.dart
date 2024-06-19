import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/global/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/global/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: 'Halo, Admin!',
          showSearch: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Obx(() {
          if (!homeController.isConnected.value) {
            return Center(
              child: Text(
                'Tidak ada koneksi internet mohon cek internet anda',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }
          return SingleChildScrollView(
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
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_SALES_PAGE);
                          },
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
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_SALES_PAGE);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pesanan',
                        style: subHeadOrderTextStyle,
                      ),
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
          );
        }),
      ),
    );
  }
}
