import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/model/customers.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class DetailCustomersPage extends StatelessWidget {
  final CustomerData customer;
  const DetailCustomersPage({Key? key, required this.customer})
      : super(key: key);

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
        title: Text('Detail Pelanggan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.25,
                child: customer.profilePicture != null
                    ? Image.network(
                        customer.profilePicture!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        Images.userImage,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: nameProductDetailTextStyle,
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  customer.userVerified == 'Verifikasi'
                      ? 'Verifikasi'
                      : 'Belum Verifikasi',
                  style: customer.userVerified == 'Verifikasi'
                      ? verificationTextStyle
                      : unverificationTextStyle,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nomor Telepon',
                  style: descProductDetailTextStyle,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  customer.phoneNumber,
                  style: desccontentProductDetailTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.1, // Menggunakan 10% tinggi layar
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: priceHProductDetailTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    customer.email,
                    style: priceCProductDetailTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.pencil),
                      onPressed: () {
                        Get.toNamed(Routes.EDIT_CUSTOMERS_PAGE);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
