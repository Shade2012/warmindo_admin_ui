import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/global/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
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
    final OrderController controller = Get.put(OrderController());

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
            return Center(
              child: CircularProgressIndicator(
                color: ColorResources.primaryColor,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchDataOrder(); // Memanggil metode untuk memperbarui pesanan
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Membuat list selalu bisa di-scroll untuk refresh
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
                  Container(
                    height: screenHeight * 0.6,
                    child: Obx(() => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Membuat list tidak bisa di-scroll terpisah
                      scrollDirection: Axis.vertical,
                      itemCount: controller.orderList.length,
                      itemBuilder: (context, index) {
                        final order = controller.orderList[index];
                        final userId = int.tryParse(order.userId.toString()) ?? 0;
                        final customer = controller.getCustomerById(userId);
                        print('Order ID: ${order.orderId}, User ID: ${order.userId}, Customer: ${customer?.name}');
                        return OrderBox(
                          order: order,
                          customerName: customer?.name ?? 'Unknown Customer',
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
