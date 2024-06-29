import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/customers.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/customers_page/controller/customers_controller.dart';
import 'package:warmindo_admin_ui/pages/edit_customers_page/controller/edit_customers_controller.dart';
import 'package:warmindo_admin_ui/pages/login_page/controller/login_controller.dart';

class EditCustomersPage extends StatelessWidget {
  final CustomerData customers;
  final TextEditingController ctrNameUser = TextEditingController();
  final TextEditingController ctrEmailUser = TextEditingController();
  final TextEditingController ctrPhoneUser = TextEditingController();
  final EditCustomersController editCustomersController =
      Get.put(EditCustomersController());
  final CustomersController dataCustomers = Get.put(CustomersController());
  final LoginController loginController = Get.put(LoginController());
  final selectedStatus = RxString('');

  EditCustomersPage({required this.customers}) {
    ctrNameUser.text = customers.name;
    ctrEmailUser.text = customers.email;
    ctrPhoneUser.text = customers.phoneNumber;
    selectedStatus.value =
        customers.userVerified == 0 ? 'Terverifikasi' : 'Belum Terverifikasi';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
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
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        title: Text('Edit Customers'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text("Nama User", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: ctrNameUser,
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("No Telepon", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: ctrPhoneUser,
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("Email", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: ctrEmailUser,
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("Status User", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              Obx(() => CustomDropdown(
                    items: ['Terverifikasi', 'Belum Terverifikasi'],
                    value: selectedStatus.value.isNotEmpty
                        ? selectedStatus.value
                        : null,
                    onChanged: (String? value) {
                      selectedStatus.value = value ?? '';
                    },
                    dropdownType: DropdownType.Status,
                  )),
              SizedBox(height: screenHeight * 0.20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    editCustomersController.updateCustomers(
                      id: customers.id.toString(),
                      userVerified:selectedStatus.value == 'Terverifikasi' ? '1' : '0',
                    );
                  },
                  child: Text('Edit Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
