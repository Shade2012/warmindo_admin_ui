import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/pages/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class EditProductPage extends StatelessWidget {
  final TextEditingController ctrProductName = TextEditingController();
  final TextEditingController ctrProductPrice = TextEditingController();
  final TextEditingController ctrProductDesc = TextEditingController();
  final TextEditingController ctrProductStock = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxString('');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
              child: Icon(Icons.arrow_back_ios_new, 
              ),
            ),
          ),
        ),
        title: Text('Ubah Data Produk'),
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
                    height: 120,
                    width: 120,
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
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(Icons.camera_alt, size: 24),
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
                  controller: ctrProductName,
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
                  controller: ctrProductPrice,
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
                  value: selectedCategory.value.isNotEmpty
                      ? selectedCategory.value
                      : null,
                  onChanged: (String? value) {
                    selectedCategory.value = value ?? '';
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
                  value: selectedStock.value.isNotEmpty
                      ? selectedStock.value
                      : null,
                  onChanged: (String? value) {
                    selectedStock.value = value ?? '';
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
                  controller: ctrProductDesc,
                  hintText: "Ex: Mie Ayam Pedas Mantap",
                  minLines: 3,
                  maxLines: 5,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lakukan penanganan input disini
                },
                child: Text('Ubah Data Produk'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
