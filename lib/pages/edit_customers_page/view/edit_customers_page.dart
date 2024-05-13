import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown.dart';
import 'package:warmindo_admin_ui/pages/widget/textfield.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class EditCustomersPage extends StatelessWidget {
  final TextEditingController ctrNameUser = TextEditingController();
  final TextEditingController ctrEmailUser = TextEditingController();
  final TextEditingController ctrPhoneUser = TextEditingController();
  final TextEditingController ctrIdUser = TextEditingController();
  final selectedStatus = RxString('');

  EditCustomersPage({Key? key}) : super(key: key);

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
                hintText: "Damar Fikri",
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("ID User", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: ctrIdUser,
                hintText: "12345",
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("No Telepon", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: ctrPhoneUser,
                hintText: "081234567890",
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("Email", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: ctrEmailUser,
                hintText: "damar@example.com",
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("Status User", style: titleAddProductTextStyle),
              SizedBox(height: screenHeight * 0.01),
              Obx(() => CustomDropdown(
                    items: ['Telah Terveritifikasi', 'Belum Terveritifikasi'],
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
                    // Lakukan penanganan input disini
                  },
                  child: Text('Edit Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.35),
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
