import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/add_varian_page/controller/add_varian_controller.dart';

class AddVarianPage extends StatelessWidget {
  final AddVarianController varianController = Get.put(AddVarianController());
  final TextEditingController ctrProductName = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxInt(0);

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
        title: Text('Tambahkan Varian Produk'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Varian", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  controller: ctrProductName,
                  hintText: "Ayam Bawang",
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kategori Varian", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                Obx(() => CustomDropdown(
                      items: ['Mie Indomie', 'Mie Sedaap', 'Pop Ice', 'Es teh', 'Kapal Api', 'Nutrisari'],
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
                Text("Stok Varian", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                Obx(() => CustomDropdown(
                      items: ['Tersedia', 'Tidak Tersedia'],
                      value: selectedStock.value == 20
                          ? 'Tersedia'
                          : "Tidak Tersedia",
                      onChanged: (String? value) {
                        if (value == 'Tersedia') {
                          selectedStock.value = 20;
                        } else if (value == 'Tidak Tersedia') {
                          selectedStock.value = 0;
                        }
                      },
                      dropdownType: DropdownType.Stock,
                    )),
              ],
            ),
            SizedBox(height: screenHeight * 0.42),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate inputs
                  if (ctrProductName.text.isEmpty || selectedCategory.value.isEmpty) {
                    Get.snackbar(
                      'Warning',
                      'Semua data harus diisi dan valid',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  varianController.addVariants(
                    nameVariant: ctrProductName.text,
                    category: selectedCategory.value,
                    stock: selectedStock.value,
                  );
                },
                child: Text('Tambahkan Varian'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
