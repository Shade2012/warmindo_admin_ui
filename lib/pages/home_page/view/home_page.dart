import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/global/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/global/widget/orderfilterBox.dart';
import 'package:warmindo_admin_ui/pages/home_page/controller/home_controller.dart';
import 'package:warmindo_admin_ui/pages/home_page/widget/homepage_shimmer.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/controller/sales_detail_controller.dart';
import 'package:warmindo_admin_ui/pages/schedule_page/controller/schedule_controller.dart';
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
    final OrderController orderController = Get.put(OrderController());
    final ScheduleController scheduleController = Get.put(ScheduleController());
    final SalesController salesController = Get.put(SalesController());

    bool isOpen = false;
    try {
      isOpen = scheduleController.jadwalElement[0].is_open;
    } catch (e) {
      isOpen = false;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: homeController.getGreeting(),
          showSearch: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Obx(() {
          // Check for internet connection
          if (!homeController.isConnected.value) {
            return Center(
              child: Text(
                'Tidak ada koneksi internet mohon cek internet anda',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }

          // Check for loading status
          if (orderController.isLoading.value || salesController.isLoading.value) {
            return HomepageShimmer();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await orderController.fetchDataOrder();
              await scheduleController.fetchScheduleList();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: isOpen ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Status Toko : ${isOpen ? 'Buka' : 'Tutup'}',
                        style: subHeadOrderTextStyle.copyWith(
                          color: Colors.white, // Warna teks selalu putih
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: AnalyticBox(
                            totalSales: salesController.revenueChart.value.overalltotal ?? 0,
                            titleAnalyticBox: 'Total Penjualan',
                            imagePath: IconThemes.iconCoin,
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_SALES_PAGE);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: AnalyticBox(
                            totalSales: salesController.salesChart.value.overalltotal ?? 0,
                            titleAnalyticBox: 'Total Produk Terjual',
                            imagePath: IconThemes.iconProduct,
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_SALES_PAGE);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: OrderFilterBox(
                            totalOrders: orderController.getOrderCountByStatus('sedang diproses'),
                            titleFilterBox: 'Sedang Diproses',
                            imagePath: IconThemes.iconOrderProgress,
                            filterStatus: 'sedang diproses',
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: OrderFilterBox(
                            totalOrders: orderController.getOrderCountByStatus('konfirmasi pesanan'),
                            titleFilterBox: 'Konfirmasi Pesanan',
                            imagePath: IconThemes.iconOrderDone,
                            filterStatus: 'konfirmasi pesanan',
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
                    child: Obx(() {
                      // Filter orders based on specific statuses
                      final filteredOrders = orderController.orderList
                          .where((order) =>
                              order.status.toLowerCase() != 'menunggu pembayaran' &&
                              order.status.toLowerCase() != 'menunggu batal' &&
                              order.status.toLowerCase() != 'batal' &&
                              order.status.toLowerCase() != 'selesai' &&
                              order.status.toLowerCase() != 'pesanan siap' &&
                              order.status.toLowerCase() != 'menunggu pengembalian dana' &&
                              order.status.toLowerCase() != 'konfirmasi pesanan')
                          .toList()
                        ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

                      if (filteredOrders.isEmpty) {
                        return Center(
                          child: Text(
                            'Tidak ada pesanan yang harus diproses',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: filteredOrders.length.clamp(0, 3),
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          final userId = int.tryParse(order.userId.toString()) ?? 0;
                          final customer = orderController.getCustomerById(userId);
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
                      );
                    }),
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
