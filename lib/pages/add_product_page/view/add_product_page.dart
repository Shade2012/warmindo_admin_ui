import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/controller/add_product_controller.dart';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/pages/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class AddProductPage extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());
  // final selectedCategory = RxString('');
  // final selectedStock = RxString('');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
        ),
        title: Text('Tambahkan Produk'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: screenHeight * 0.15,
                    width: screenHeight * 0.15,
                    child: Image.asset(Images.defaultImage),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => UploadImage(),
                        );
                      },
                      child: Container(
                        width: screenHeight * 0.04,
                        height: screenHeight * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            Icon(Icons.camera_alt, size: screenHeight * 0.05),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Produk", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  controller: controller.ctrProductName,
                  hintText: "Ex: Mie Ayam",
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Harga Produk", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  controller: controller.ctrProductPrice,
                  hintText: "Ex: 15000",
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kategori Produk", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                Obx(() => CustomDropdown(
                      items: ['Makanan', 'Minuman', 'Snack'],
                      value: controller.selectedCategory.value.isNotEmpty
                          ? controller.selectedCategory.value
                          : null,
                      onChanged: (String? value) {
                        controller.selectedCategory.value = value ?? '';
                      },
                      dropdownType: DropdownType.Category,
                    )),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stok Produk", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                Obx(() => CustomDropdown(
                      items: ['Tersedia', 'Tidak Tersedia'],
                      value: controller.selectedStock.value.isNotEmpty
                          ? controller.selectedStock.value
                          : null,
                      onChanged: (String? value) {
                        controller.selectedStock.value = value ?? '';
                      },
                      dropdownType: DropdownType.Stock,
                    )),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Deskripsi Produk", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  controller: controller.ctrProductDesc,
                  hintText: "Ex: Mie Ayam Pedas Mantap",
                  minLines: 3,
                  maxLines: 5,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // Panggil fungsi addMenu dari AddProductController untuk menambahkan produk baru
                    await controller.addMenu();
                    Get.snackbar(
                      "Sukses",
                      "Produk berhasil ditambahkan",
                      snackPosition: SnackPosition.TOP,
                    );
                    // Kosongkan input setelah berhasil menambahkan produk
                    controller.ctrProductName.clear();
                    controller.ctrProductPrice.clear();
                    controller.ctrProductDesc.clear();
                    controller.selectedCategory.value = '';
                    controller.selectedStock.value = '';
                  } catch (e) {
                    // Tampilkan pesan kesalahan jika gagal menambahkan produk
                    Get.snackbar(
                      "Error",
                      "Gagal menambahkan produk. Error: $e",
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
                child: Text('Tambahkan Produk'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
