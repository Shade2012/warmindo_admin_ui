import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class EditOrderPage extends StatelessWidget {
  late final Order order;
  final TextEditingController ctrNameUser = TextEditingController();
  final TextEditingController ctrPrice = TextEditingController();
  final TextEditingController ctrIdOrder = TextEditingController();
  final selectedCategory = RxString('');

  // EditOrderPage(this.order) {
  // ctrNameUser.text = order.nameCustomer;
  // ctrIdOrder.text = order.id;
  // selectedCategory.value = order.status;
  // }

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
              width: screenHeight * 0.04,
              height: screenHeight * 0.04,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * 0.01),
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
                size: screenHeight * 0.02,
              ),
            ),
          ),
        ),
        title: Text('Edit Pesanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama User', style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              controller: ctrNameUser,
              hintText: 'Masukkan Nama User',
              readOnly: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text('Harga', style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              controller: ctrPrice,
              hintText: 'Masukkan Harga',
              readOnly: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text('ID Pesanan', style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              controller: ctrIdOrder,
              hintText: 'Masukkan ID Pesanan',
              readOnly: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text("Kategori Produk", style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            Obx(() => CustomDropdown(
                  items: ['Proses', 'Selesai', 'Menunggu Diambil'],
                  value: selectedCategory.value.isNotEmpty
                      ? selectedCategory.value
                      : null,
                  onChanged: (String? value) {
                    selectedCategory.value = value ?? '';
                  },
                  dropdownType: DropdownType.Category,
                )),
            SizedBox(height: screenHeight * 0.33),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lakukan penanganan input disini
                },
                child: Text('Ubah Status'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
