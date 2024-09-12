import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/controller/edit_order_controller.dart';

class EditOrderPage extends StatelessWidget {
  final Order order;
  final EditOrderController editOrderController = Get.put(EditOrderController());
  final TextEditingController ctrUserId = TextEditingController();
  final TextEditingController ctrPrice = TextEditingController();
  final TextEditingController ctrMenuId = TextEditingController();
  final TextEditingController ctrRefund = TextEditingController();
  final selectedCategory = RxString('');

  EditOrderPage({required this.order}) {
    ctrUserId.text = order.userId;
    ctrPrice.text = order.priceOrder.toString();
    ctrMenuId.text = order.id.toString();
    selectedCategory.value = order.status;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine available status options based on the current status
    List<String> statusOptions = [
      'sedang diproses', 
      'selesai', 
      'pesanan siap', 
      'batal', 
      'menunggu pengembalian dana'
      'sedang dikirim'
    ];

    if (selectedCategory.value == 'menunggu pengembalian dana') {
      statusOptions = ['menunggu pengembalian dana','batal'];
    }

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
            Text('User ID', style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              controller: ctrUserId,
              hintText: 'Masukkan ID User',
              readOnly: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text('Harga', style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              controller: ctrPrice,
              hintText: 'Masukkan Harga',
              readOnly: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text("Status Pesanan", style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            Obx(() => CustomDropdown(
                  items: statusOptions,
                  value: selectedCategory.value.isNotEmpty
                      ? selectedCategory.value
                      : null,
                  onChanged: (String? value) {
                    selectedCategory.value = value ?? '';
                  },
                  dropdownType: DropdownType.Status,
                )),
            SizedBox(height: screenHeight * 0.45),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  editOrderController.updateOrder(
                    orderId: order.id.toString(),
                    status: selectedCategory.value,
                  );
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
