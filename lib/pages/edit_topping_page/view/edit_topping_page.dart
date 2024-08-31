import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/pages/edit_topping_page/controller/edit_topping_controller.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class EditToppingPage extends StatelessWidget {
  final Menu topping;
  final TextEditingController ctrToppingName = TextEditingController();
  final TextEditingController ctrToppingPrice = TextEditingController();
  final TextEditingController ctrToppingStock = TextEditingController();
  final EditToppingController editToppingController = Get.put(EditToppingController());
  final ProductController productController = Get.put(ProductController());

  EditToppingPage({required this.topping}) {
    ctrToppingName.text = topping.nameMenu;
    ctrToppingPrice.text = topping.price;
    ctrToppingStock.text = topping.stock;
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
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Menu Id", style: titleAddProductTextStyle),
                    SizedBox(height: screenHeight * 0.01),
                    InkWell(
                      onTap: () {
                        editToppingController.showDetailPopupModal(context);
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
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final stockValue = int.tryParse(ctrToppingStock.text) ?? 0;
                      final priceValue = double.tryParse(ctrToppingPrice.text) ?? 0.0;

                      // Debug print to check the values
                      print("Name: ${ctrToppingName.text}");
                      print("Price: $priceValue");
                      print("Stock: $stockValue");

                      editToppingController.postSelectedToppings(
                        toppingId: topping.id,
                        nameTopping: ctrToppingName.text,
                        price: priceValue,
                        stock: stockValue,
                        menu_ids: productController.selectedMenuIds,
                      );
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
