import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/global/widget/textfield.dart';
import 'package:warmindo_admin_ui/pages/input_notification_page/controller/input_notification_controller.dart';
import 'package:warmindo_admin_ui/pages/input_notification_page/widget/device_preview.dart';

class InputNotificationPage extends StatelessWidget {
  final InputNotificationController controller = Get.put(InputNotificationController());

  InputNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Notifikasi', style: appBarTextStyle),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.025),
            Text(
              'Pratinjau Notifikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: screenHeight * 0.015),
            DevicePreview(controller: controller),
            SizedBox(height: screenHeight * 0.025),
            Text(
              'Judul Notifikasi',
              style: titleAddProductTextStyle,
            ),
            SizedBox(height: screenHeight * 0.015),
            CustomTextField(
              controller: TextEditingController(text: controller.title.value),
              hintText: 'Judul Notifikasi',
              onChanged: (value) => controller.title.value = value,
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              'Deskripsi Notifikasi',
              style: titleAddProductTextStyle,
            ),
            SizedBox(height: screenHeight * 0.015),
            CustomTextField(
              controller: TextEditingController(text: controller.description.value),
              hintText: 'Deskripsi Notifikasi',
              onChanged: (value) => controller.description.value = value,
            ),
            SizedBox(height: screenHeight * 0.025),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.primaryColorDark.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(screenWidth * 0.5, screenHeight * 0.07),
                    foregroundColor: ColorResources.primaryColorDark,
                    backgroundColor: ColorResources.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorResources.primaryColorDark),
                    ),
                  ),
                  onPressed: () {
                    controller.sendNotification();
                  },
                  child: Text('Kirim Notifikasi'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
