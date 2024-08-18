import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/global/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_admin_ui/pages/home_page/widget/homepage_shimmer.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

import '../../schedule_page/controller/schedule_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final HomeController homeController = Get.put(HomeController());
    final OrderController controller = Get.put(OrderController());
    final ScheduleController statusController = Get.put(ScheduleController());

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
          if (controller.isLoading.value) {
            return HomepageShimmer();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchDataOrder();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(screenWidth * 0.02),
                    // child: Text('Status Toko : ${statusController.jadwalElement[0].is_open ? 'Buka' : 'Tutup'}',style: subHeadOrderTextStyle,),
                  ),
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
                  Container(
                    height: screenHeight * 0.6,
                    child: Obx(() => ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.orderList.length.clamp(0, 3),
                          itemBuilder: (context, index) {
                            final order = controller.orderList[index];
                            final userId = int.tryParse(order.userId.toString()) ?? 0;
                            final customer = controller.getCustomerById(userId);
                            print('Order ID: ${order.id}, User ID: ${order.userId}, Customer: ${customer?.name}');
                            return OrderBox(
                              order: order,
                              customerName:
                              customer?.name ?? 'Unknown Customer',
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

