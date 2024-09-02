import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/edit_varian_page/controller/edit_varian_controller.dart';

class EditVarianPage extends StatelessWidget {
  final Menu varian;
  final EditVariantController varianController =
      Get.put(EditVariantController());
  final TextEditingController ctrProductName = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxString('');

  EditVarianPage({required this.varian}) {
    ctrProductName.text = varian.nameMenu;
    selectedCategory.value = varian.secondCategory;
    print(selectedCategory.value);
    selectedStock.value = varian.stock == '0' ? 'Tidak Tersedia' : 'Tersedia';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final stockItems = ['Tersedia', 'Tidak Tersedia'];
    final categories = ['Mie Indomie', 'Mie Sedaap', 'Pop Ice', 'Es teh', 'Kapal Api', 'Nutrisari'];

    // Ensure the selected values are valid
    if (!categories.contains(selectedCategory.value)) {
      selectedCategory.value = categories.first;
    }
    if (!stockItems.contains(selectedStock.value)) {
      selectedStock.value = stockItems.first;
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
              Get.back();
            },
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
        title: Text('Ubah Varian'),
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
                Text("Kategori", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                Obx(() => CustomDropdown(
                      items: categories,
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
                      items: stockItems,
                      value: stockItems.contains(selectedStock.value)
                          ? selectedStock.value
                          : null,
                      onChanged: (String? value) {
                        selectedStock.value = value ?? '';
                      },
                      dropdownType: DropdownType.Stock,
                    )),
              ],
            ),
            SizedBox(height: screenHeight * 0.024),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (ctrProductName.text.isEmpty ||
                      selectedCategory.value.isEmpty ||
                      selectedStock.value.isEmpty) {
                    Get.snackbar(
                      'Warning',
                      'Semua data harus diisi dan valid',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  varianController.updateVarian(
                    varianId: varian.id.toString(),
                    nameVarian: ctrProductName.text,
                    category: selectedCategory.value,
                    stock: selectedStock.value == 'Tersedia' ? 20 : 0,
                  );
                },
                child: Text('Ubah Produk'),
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
