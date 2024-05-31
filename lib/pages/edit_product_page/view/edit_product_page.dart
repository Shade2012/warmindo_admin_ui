import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_product_page/controller/edit_product_controller.dart';
import 'package:warmindo_admin_ui/pages/model/product_response.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/pages/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class EditProductPage extends StatelessWidget {
  final Menu product;
  final TextEditingController ctrProductName = TextEditingController();
  final TextEditingController ctrProductPrice = TextEditingController();
  final TextEditingController ctrProductDesc = TextEditingController();
  final TextEditingController ctrProductStock = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxString('');
  final ProductController productController = Get.put(ProductController());
  final EditProductController editProductController =
      Get.put(EditProductController());

  EditProductPage({required this.product}) {
    ctrProductName.text = product.nameMenu;
    ctrProductPrice.text = product.price;
    ctrProductDesc.text = product.description;
    // selectedCategory.value = product.category?.toString() ?? '';
    // selectedStock.value = product.stock?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(screenHeight * 0.01),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: screenHeight * 0.08,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * 0.025),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        title: Text('Ubah Data Produk'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => UploadImage(),
                      );
                    },
                    child: SizedBox(
                      height: screenHeight * 0.15,
                      width: screenHeight * 0.15,
                      child:
                          editProductController.selectedImage.value != null &&
                                  editProductController
                                      .selectedImage.value!.path.isNotEmpty
                              ? Image.file(
                                  File(editProductController
                                      .selectedImage.value!.path),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(product.image),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Wrap(
                                children: [
                                  UploadImage(),
                                ],
                              ),
                            );
                          },
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
                      value: selectedStock.value == "20"
                          ? 'Tersedia'
                          : "Tidak Tersedia",
                      onChanged: (String? value) {
                        if (value == 'Tersedia') {
                          selectedStock.value = "20";
                        } else if (value == 'Tidak Tersedia') {
                          selectedStock.value = "0";
                        }
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
                  final selectedImage =
                      editProductController.selectedImage.value;
                  if (selectedImage != null) {
                    editProductController.updateProduct(
                        menuId: product.menuId.toString(),
                        nameMenu: ctrProductName.text,
                        price: int.parse(ctrProductPrice.text),
                        category: selectedCategory.value,
                        stock: int.parse(selectedStock.value),
                        ratings: 4.5,
                        description: ctrProductDesc.text,
                        image: selectedImage);
                  } else {
                    // Handle the case when no image is selected
                    print('No image selected');
                  }
                },
                child: Text('Ubah Data Produk'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.28),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
