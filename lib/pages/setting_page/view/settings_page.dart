import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/controller/general_info_controller.dart';
import 'package:warmindo_admin_ui/pages/setting_page/controller/settings_controller.dart';
import 'package:warmindo_admin_ui/pages/setting_page/widget/bottom_sheet_shop.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final GeneralInformationController generalInfor =
      Get.put(GeneralInformationController());
  SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: screenWidth,
                  height: screenHeight * 0.35,
                  color: ColorResources.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: FadeInImage(
                          placeholder: AssetImage(Images.userImage),
                          image: NetworkImage(generalInfor.image.value.isEmpty
                              ? Images.userImage
                              : generalInfor.image.value),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: screenWidth * 0.4,
                            child: Image.asset(Images.userImage),
                          ),
                          width: screenWidth * 0.4,
                          height: screenWidth * 0.4,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        generalInfor.fullNameController.text,
                        style: nameProfileTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Akun',
                          style: headercontentProfileTextStyle,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          width: screenWidth * 0.9,
                          padding: EdgeInsets.all(screenWidth * 0.025),
                          decoration: BoxDecoration(
                            color: ColorResources.wProfileBg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  'Informasi Umum',
                                  style: contentProfileTextStyle,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Get.toNamed(Routes.GENERAL_INFORMATION_PAGE);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.security),
                                title: Text(
                                  'Ubah Kata Sandi',
                                  style: contentProfileTextStyle,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Get.toNamed(Routes.CHANGEPASS_PAGE);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Toko',
                          style: headercontentProfileTextStyle,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          width: screenWidth * 0.9,
                          padding: EdgeInsets.all(screenWidth * 0.025),
                          decoration: BoxDecoration(
                            color: ColorResources.wProfileBg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(FontAwesomeIcons.store),
                                title: Text(
                                  'Toko',
                                  style: contentProfileTextStyle,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    builder: (BuildContext context) {
                                      return BottomSheetShop(
                                        scheduleId: 0,
                                      );
                                    },
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.notifications),
                                title: Text(
                                  'Notifikasi',
                                  style: contentProfileTextStyle,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Get.toNamed(Routes.INPUT_NOTIFICATION_PAGE);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.logout),
                                title: Text(
                                  'Keluar',
                                  style: contentProfileTextStyle,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  controller.logOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
