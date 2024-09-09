import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/global/widget/orderBox.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';
import 'package:warmindo_admin_ui/pages/order_page/shimmer/order_shimmer.dart';
import 'package:warmindo_admin_ui/pages/order_page/widget/order_filter_dropdown.dart';

class OrderPage extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> selectedStatus = ValueNotifier<String>('Semua');
  final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Ambil argumen dari Get.to
    final String? filterStatus = Get.arguments as String?;

    // Set nilai default jika tidak ada filterStatus
    if (filterStatus != null) {
      selectedStatus.value = filterStatus;
    }

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<bool>(
          valueListenable: isSearching,
          builder: (context, isSearchingValue, child) {
            return isSearchingValue
                ? TextField(
                    controller: searchController,
                    autofocus: true,
                    onChanged: (value) {
                      controller.update(); 
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari nama pelanggan',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  )
                : Text(
                    'Manajemen Pesanan',
                    style: appBarTextStyle,
                  );
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: isSearching,
            builder: (context, isSearchingValue, child) {
              return IconButton(
                icon: Icon(
                  isSearchingValue ? Icons.close : Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (isSearchingValue) {
                    searchController.clear();
                    isSearching.value = false;
                    controller.update(); 
                  } else {
                    isSearching.value = true;
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: filterStatus == null
                ? Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: OrderFilterDropdown(
                      orders: controller.orderList,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      selectedStatus: selectedStatus,
                      onChanged: (String? newValue) async {
                        selectedStatus.value = newValue ?? 'Semua'; 
                        await controller.fetchDataOrder(); 
                      },
                    ),
                  )
                : SizedBox.shrink(),
          ),
          Positioned(
            top: filterStatus == null
                ? MediaQuery.of(context).padding.top + kToolbarHeight + 2
                : 0, // Mengatur top menjadi 0 jika dropdown tidak ditampilkan
            left: 0,
            right: 0,
            bottom: 0,
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchDataOrder();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value) {
                          return OrderShimmer();
                        }

                        final filteredOrders = controller.getFilteredOrders(
                            controller.orderList,
                            selectedStatus.value,
                            searchController.text);

                        if (filteredOrders.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak ada pesanan yang tersedia.',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          );
                        }

                        return Column(
                          children: filteredOrders.map((order) {
                            final customer = controller.getCustomerById(int.tryParse(order.userId) ?? 0);
                            return Column(
                              children: [
                                OrderBox(
                                  order: order,
                                  customerName: customer?.name ?? 'Unknown Customer',
                                ),
                                SizedBox(height: screenHeight * 0.02),
                              ],
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
