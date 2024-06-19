import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class AddToppingPage extends StatelessWidget {
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
            SizedBox(height: screenHeight * 0.28),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add product to database
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
