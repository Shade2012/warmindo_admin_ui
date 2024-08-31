import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/add_topping_page/controller/add_topping_controller.dart';

import '../../product_page/controller/product_controller.dart';

class AddToppingPage extends StatelessWidget {
  final AddToppingController toppingController = Get.put(AddToppingController());
  final ProductController productController = Get.put(ProductController());
  final TextEditingController ctrProductName = TextEditingController();
  final TextEditingController ctrProductPrice = TextEditingController();
  final TextEditingController ctrProductStock = TextEditingController();

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
        title: Text('Tambahkan Topping'),
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
                Text("Nama Topping", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  controller: ctrProductName,
                  hintText: "Telur Dadar",
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Harga", style: titleAddProductTextStyle),
                SizedBox(height: screenHeight * 0.01),
                CustomTextField(
                  controller: ctrProductPrice,
                  hintText: "Rp 10.000",
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Stock", style: titleAddProductTextStyle),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      width: screenWidth * 0.15,
                      child: CustomTextField(
                        controller: ctrProductStock,
                        hintText: "10 pcs",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Menu Id", style: titleAddProductTextStyle),
                    SizedBox(height: screenHeight * 0.01),
                    InkWell(
                      onTap: () {
                        toppingController.showDetailPopupModal(context);
                      },
                      child: Container(
                        width: screenWidth * 0.15, // Adjust width as needed
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Center(
                          child: Obx(() {
                            final selectedMenuIds = productController.selectedMenuIds.reversed; // Assuming this is an RxList<int> in your controller
                            final idsText = selectedMenuIds.isNotEmpty
                                ? selectedMenuIds.join(', ')
                                : 'Id';

                            return Text(
                              idsText,
                              style: regulargreyText,
                              overflow: TextOverflow.ellipsis, // Handle overflow
                              maxLines: 1, // Ensure text doesn't wrap to a new line
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.28),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final toppingName = ctrProductName.text;
                  final toppingPrice = double.tryParse(ctrProductPrice.text);
                  final toppingStock = int.tryParse(ctrProductStock.text);

                  if (toppingName.isEmpty || toppingPrice == null || toppingStock == null) {
                    Get.snackbar(
                      'Warning',
                      'Semua data harus diisi',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                  }else if(productController.selectedMenuIds.isEmpty){
                    Get.snackbar(
                      'Warning',
                      'Pilih setidaknya satu menu ID',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                  } else {

                    toppingController.postSelectedToppings(
                      nameTopping: toppingName,
                      price: toppingPrice,
                      statusTopping: '1',
                      stock: toppingStock,
                      menu_ids: productController.selectedMenuIds.value
                    );
                  }
                },
                child: Text('Tambahkan'),
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
