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
  SettingsPage({Key? key}) : super(key: key);

  final SettingsController controller = Get.put(SettingsController());
  final GeneralInformationController generalInfor = Get.put(GeneralInformationController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      return Scaffold(
        backgroundColor: ColorResources.primaryColor,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              generalInfor.fetchData(); // Assuming this method refreshes the general information
            },
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Section
                    Container(
                      margin: EdgeInsets.only(bottom: screenWidth * 0.05),
                      width: screenWidth,
                      height: screenHeight * 0.3,
                      color: ColorResources.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: FadeInImage(
                              placeholder: AssetImage(Images.userImage),
                              image: NetworkImage(generalInfor.image.value.isEmpty
                                  ? 'https://ui-avatars.com/api/?background=random&color=ffffff&name=${generalInfor.usernameController.value}&size=128'
                                  : 'https://warmindoanggrekmuria.my.id/image/' + generalInfor.image.value),
                              width: screenWidth * 0.4,
                              height: screenWidth * 0.4,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            generalInfor.usernameController.text,
                            style: nameProfileTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // Settings Sections
                    Container(
                      width: screenWidth,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          // Account Section
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
                          // Shop Section
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
                                    'Pengaturan Toko',
                                    style: contentProfileTextStyle,
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
