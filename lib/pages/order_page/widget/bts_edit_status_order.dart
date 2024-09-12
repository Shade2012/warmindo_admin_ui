import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/model_order.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/controller/edit_order_controller.dart';

class EditOrderBottomSheet extends StatelessWidget {
  final Order order;
  final EditOrderController editOrderController = Get.put(EditOrderController());
  final TextEditingController ctrUserId = TextEditingController();
  final TextEditingController ctrPrice = TextEditingController();
  final TextEditingController ctrMenuId = TextEditingController();
  final TextEditingController ctrRefund = TextEditingController();
  final selectedCategory = RxString('');

  EditOrderBottomSheet({required this.order}) {
    ctrUserId.text = order.id.toString();
    ctrPrice.text = order.priceOrder.toString();
    ctrMenuId.text = order.id.toString();
    selectedCategory.value = order.status;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPendingCancellation = order.status.toLowerCase() == 'menunggu pengembalian dana';

    // Dropdown items based on the status
    final dropdownItems = isPendingCancellation
        ? ['menunggu pengembalian dana','batal']
        : ['konfirmasi pesanan','sedang diproses', 'sedang diantar','pesanan siap','selesai'];

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
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
                SizedBox(width: screenWidth * 0.02),
                Text('Edit Status Pesanan', style: appBarTextStyle),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Text("Status Pesanan", style: titleAddProductTextStyle),
            SizedBox(height: screenHeight * 0.01),
            Obx(() => CustomDropdown(
                  items: dropdownItems,
                  value: selectedCategory.value.isNotEmpty
                      ? selectedCategory.value
                      : null,
                  onChanged: (String? value) {
                    selectedCategory.value = value ?? '';
                  },
                  dropdownType: DropdownType.Status,
                )),
            SizedBox(height: screenHeight * 0.20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  editOrderController.updateOrder(
                    orderId: order.id.toString(),
                    status: selectedCategory.value,
                  );
                  Get.back();
                },
                child: Text('Ubah Status'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to display BottomSheet
void showEditOrderBottomSheet(BuildContext context, Order order) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditOrderBottomSheet(order: order),
      );
    },
  );
}
