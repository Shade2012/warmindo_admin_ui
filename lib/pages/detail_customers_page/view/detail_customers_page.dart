import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/customers.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class DetailCustomersPage extends StatelessWidget {
  final CustomerData customerData;
  DetailCustomersPage({required this.customerData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Detail Pelanggan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      Images.userImage,
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.16),
                TextFormField(
                  readOnly: true,
                  initialValue: customerData.name,
                  decoration: InputDecoration(
                    labelText: "Nama",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  readOnly: true,
                  initialValue: customerData.email,
                  decoration: InputDecoration(
                    labelText: "Alamat Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  readOnly: true,
                  initialValue: customerData.phoneNumber,
                  decoration: InputDecoration(
                    labelText: "Nomor Telepon",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  
                  readOnly: true,
                  initialValue: customerData.userVerified == '0'
                      ? "Belum Terverifikasi"
                      : "Sudah Terverifikasi",
                  decoration: InputDecoration(
                    labelText: "Status Verifikasi",
                    border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.ORDER_HISTORY_PAGE, arguments: customerData.name);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.2, screenHeight * 0.05),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text("Tampilkan Riwayat Pesanan"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.EDIT_CUSTOMERS_PAGE, arguments: customerData);
        },
        backgroundColor: Colors.red,
        child: Icon(
          FontAwesomeIcons.pencil,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
