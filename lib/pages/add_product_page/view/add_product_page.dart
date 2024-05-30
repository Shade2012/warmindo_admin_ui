import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/controller/add_product_controller.dart';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/pages/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

import '../../../data/api_controller.dart';

class AddProductPage extends StatelessWidget {
  final AddProductController dataController = Get.put(AddProductController());
  final TextEditingController ctrProductName = TextEditingController();
  final TextEditingController ctrProductPrice = TextEditingController();
  final TextEditingController ctrProductDesc = TextEditingController();
  final TextEditingController ctrProductStock = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxInt(0);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
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
          body:SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Center(
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
                                child: dataController.selectedImage.value != null && dataController.selectedImage.value!.path.isNotEmpty
                                    ? Image.file(
                                        File(dataController
                                            .selectedImage.value!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(Images.defaultImage),
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
                                  child: Icon(Icons.camera_alt,
                                      size: screenHeight * 0.05),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategori Produk",
                            style: titleAddProductTextStyle),
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
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Deskripsi Produk",
                            style: titleAddProductTextStyle),
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
                              dataController.selectedImage.value;
                          if (selectedImage != null) {
                            dataController.addProduct(nameMenu: ctrProductName.text, price: int.parse(ctrProductPrice.text), category: selectedCategory.value, stock: selectedStock.value, ratings: 4.0, description: ctrProductDesc.text, image: selectedImage,
                            );
                          } else {
                            // Handle the case when no image is selected
                            print('No image selected');
                          }
                        },
                        child: Text('Tambahkan Produk'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.25),
                        ),
                      ),
                    )
                  ],
                ),
          ),
        ),
        Obx(() {
          if (dataController.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator( color: Colors.black,),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
