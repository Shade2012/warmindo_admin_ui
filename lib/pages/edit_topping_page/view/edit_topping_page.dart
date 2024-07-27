import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/model/product_response.dart'; // Pastikan import yang benar
import 'package:warmindo_admin_ui/pages/edit_topping_page/controller/edit_topping_controller.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class EditToppingPage extends StatelessWidget {
  final Menu topping; // Pastikan tipe data sesuai
  final TextEditingController ctrToppingName = TextEditingController();
  final TextEditingController ctrToppingPrice = TextEditingController();
  final TextEditingController ctrToppingStock = TextEditingController();
  final EditToppingController editToppingController =
      Get.put(EditToppingController());

  EditToppingPage({required this.topping}) {
    ctrToppingName.text = topping.nameMenu;
    ctrToppingPrice.text = topping.price;
    ctrToppingStock.text = topping.stock;
  }

  void getImage(ImageSource source) {
    editToppingController.getImage(source);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: GestureDetector(
                onTap: () => Get.offNamed(Routes.BOTTOM_NAVIGATION),
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
            title: Text('Ubah Data Topping'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(screenHeight * 0.02),
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
                            child: editToppingController.selectedImage.value !=
                                        null &&
                                    editToppingController
                                        .selectedImage.value!.path.isNotEmpty
                                ? Image.file(
                                    File(editToppingController
                                        .selectedImage.value!.path),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(topping
                                    .image), // Assuming topping has an image URL
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
                    Text("Nama Topping", style: titleAddProductTextStyle),
                    SizedBox(height: screenHeight * 0.01),
                    CustomTextField(
                      controller: ctrToppingName,
                      hintText: "Ex: Telur Dadar",
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Harga Topping", style: titleAddProductTextStyle),
                    SizedBox(height: screenHeight * 0.01),
                    CustomTextField(
                      controller: ctrToppingPrice,
                      hintText: "Ex: 10000",
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Stok Topping", style: titleAddProductTextStyle),
                    SizedBox(height: screenHeight * 0.01),
                    CustomTextField(
                      controller: ctrToppingStock,
                      hintText: "Ex: 10",
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedImage =
                          editToppingController.selectedImage.value;
                      final stockValue =
                          int.tryParse(ctrToppingStock.text) ?? 0;
                      final priceValue =
                          double.tryParse(ctrToppingPrice.text) ?? 0.0;

                      // Debug print to check the values
                      print("Name: ${ctrToppingName.text}");
                      print("Price: $priceValue");
                      print("Stock: $stockValue");

                      if (selectedImage != null) {
                        editToppingController.updateTopping(
                          toppingId: topping.id.toString(),
                          nameTopping: ctrToppingName.text,
                          price: double.tryParse(ctrToppingPrice.text) ?? 0.0,
                          stock: int.tryParse(ctrToppingStock.text) ?? 0,
                          image: selectedImage,
                        );
                      } else {
                        editToppingController.updateTopping(
                          toppingId: topping.id.toString(),
                          nameTopping: ctrToppingName.text,
                          price: double.tryParse(ctrToppingPrice.text) ?? 0.0,
                          stock: int.tryParse(ctrToppingStock.text) ?? 0,
                        );
                      }
                    },
                    child: Text('Ubah Data Topping'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (editToppingController.isLoading.value) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
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
