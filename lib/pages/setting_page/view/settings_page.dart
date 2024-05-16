import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/bottom_sheet_shop.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(Images.profileBg),
          //       fit: BoxFit.fill,
          //     ),
          //     ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: screenWidth,
                height: screenHeight * 0.3,
                color: ColorResources.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        Images.userImage,
                        width: 125,
                        height: 125,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Admin',
                      style: nameProfileTextStyle,
                    ),
                    SizedBox(height: 5),
                    // Text(
                    //   '@manusia',
                    //   style: usernameProfileTextStyle,
                    // ),
                    SizedBox(height: 15),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Get.toNamed(Routes.EDIT_PROFILE_PAGE);
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     minimumSize: Size(133, 30),
                    //     padding: EdgeInsets.all(8),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //       side: BorderSide(color: Colors.white),
                    //     ),
                    //     backgroundColor: ColorResources.primaryColor,
                    //   ),
                    //   child: Text(
                    //     'Edit Profile',
                    //     style: editProfileTextStyle,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Bagian bawah
              Expanded(
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(height: 40),
                      // Menu Akun
                      Text(
                        'Akun',
                        style: headercontentProfileTextStyle,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 327,
                        padding: EdgeInsets.all(10),
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
                      SizedBox(height: 20),
                      Text(
                        'Toko',
                        style: headercontentProfileTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 327,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorResources.wProfileBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(FontAwesomeIcons.ticket),
                              title: Text(
                                'Voucher',
                                style: contentProfileTextStyle,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Get.toNamed(Routes.VOUCHER_PAGE);
                              },
                            ),
                            ListTile(
                              leading: Icon(FontAwesomeIcons.store),
                              title: Text(
                                'Shop',
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
                                    return BottomSheetShop();
                                  },
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout),
                              title: Text(
                                'Log Out',
                                style: contentProfileTextStyle,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // Get.toNamed(Routes.SHOP_PAGE);
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
    );
  }
}
