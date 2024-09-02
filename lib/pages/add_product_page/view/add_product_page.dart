import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/controller/add_product_controller.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';


class AddProductPage extends StatelessWidget {
  final AddProductController dataController = Get.put(AddProductController());
  final TextEditingController ctrProductName = TextEditingController();
  final TextEditingController ctrProductPrice = TextEditingController();
  final TextEditingController ctrProductDesc = TextEditingController();
  final TextEditingController ctrProductStock = TextEditingController();
  final selectedCategory = RxString('');
  final selectedStock = RxInt(0);
  final selectedSecondCategory = RxString('Mie');

  @override
  Widget build(BuildContext context) {
    void getImage(ImageSource source) {
      dataController.getImage(source);
    }
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
                                  builder: (context) => UploadImage(
                                    onImageCapture: getImage,
                                  ),
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
                                            UploadImage(
                                              onImageCapture: getImage,
                                            ),
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
                        Text("Kategory Produk Kedua", style: titleAddProductTextStyle),
                        SizedBox(height: screenHeight * 0.01),
                        Obx(() => CustomDropdown(
                          items: ['Mie', 'Nasi Goreng','Ayam','Kopi','Iced','Teh','Susu','Gorengan','Ricebowl','Lain-lain'],
                          value: selectedSecondCategory.value,
                          onChanged: (String? value) {
                            selectedSecondCategory.value = value ?? '';
                          },
                          dropdownType: DropdownType.SecondCategory,
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
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Check if all required fields are filled
                          final selectedImage = dataController.selectedImage.value;
                          final productName = ctrProductName.text.trim();
                          final productPrice = ctrProductPrice.text.trim();
                          final productCategory = selectedCategory.value;
                          final productStock = selectedStock.value;

                          if (dataController.selectedImage.value.path.isEmpty|| productName.isEmpty || productPrice.isEmpty || productCategory.isEmpty) {
                            Get.snackbar(
                              'Warning',
                              'Semua data harus diisi',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                            );
                          } else {
                            final intPrice = int.tryParse(productPrice);
                            if (intPrice != null) {
                              dataController.addProduct(
                                nameMenu: productName,
                                price: intPrice,
                                category: productCategory,
                                stock: productStock,
                                ratings: 4.0,
                                description: ctrProductDesc.text,
                                image: selectedImage, secondCategory: selectedSecondCategory.value,
                              );
                            }
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
                    ),
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
