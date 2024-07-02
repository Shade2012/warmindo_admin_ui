import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import '../controller/customers_controller.dart';
import '../widget/customers_widget.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomersController controller = Get.put(CustomersController());
    final TextEditingController searchController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Verifikasi Pelanggan',
        controller: searchController,
        onChanged: (value) => controller.searchCustomers(value),
      ),
      body: Obx(() {
        if (!controller.isConnected.value) {
          return Center(
          child: Text(
            'Tidak ada koneksi internet mohon cek internet anda',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
        }
        if (controller.isLoading.value) {
          return buildShimmerList(screenWidth, screenHeight);
        } else {
          if (controller.searchResults.isEmpty) {
            return Center(
              child: Text(
                'Data Pelanggan tidak ditemukan',
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: controller.searchResults.map((customer) {
                  return GestureDetector(
                    onTap: () {
                     Get.toNamed(Routes.DETAIL_CUSTOMERS_PAGE, arguments: customer);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5), 
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.015),
                        width: screenWidth * 0.95, 
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ID Pengguna',
                                  style: headerverificationTextStyle,
                                ),
                                Text(
                                  '#${customer.id}',
                                  style: headerverificationTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: screenHeight * 0.01), 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: screenWidth * 0.15, 
                                    height: screenWidth * 0.15, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: customer.profilePicture != null
                                            ? NetworkImage(
                                                customer.profilePicture!)
                                            : AssetImage(Images.userImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: screenWidth *
                                        0.02), // Spacer antara gambar dan teks
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center, // Vertically center the text
                                  children: [
                                    Text(
                                      customer
                                          .name, // Gunakan data nama dari customer
                                      style: contentverificationTextStyle,
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                      customer.userVerified == 'Verifikasi'
                                          ? 'Verifikasi'
                                          : 'Belum Verifikasi',
                                      style: customer.userVerified == 'Verifikasi'
                                          ? verificationTextStyle
                                          : unverificationTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }
      }),
    );
  }
}