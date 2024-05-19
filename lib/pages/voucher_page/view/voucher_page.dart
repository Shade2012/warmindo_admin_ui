import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/circle_icon.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: Text('Voucher'),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Spacing between elements
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      shadowColor: Colors.grey.withOpacity(0.5),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nikmati Kelezatan Tanpa Batas dengan Diskon 15% Ayo, Segera Pesan dan Rasakan Sensasi Minum yang Luar Biasa!',
                            style: blackvoucherTextStyle,
                          ),
                          SizedBox(height: screenHeight / 70),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              CircleIcon(
                                iconData: FontAwesomeIcons.ticket,
                              ),
                              SizedBox(width: screenWidth / 30),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Code Voucher',
                                        style: blackvoucherTextStyle),
                                    Text('0LER25C', style: blackvoucherTextStyle),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight / 70),
                          Row(
                            children: [
                              CircleIcon(iconData: Icons.date_range_sharp),
                              SizedBox(width: screenWidth / 30),
                              Text('Exp 35 Januari 2025',
                                  style: blackvoucherTextStyle),
                              Text(' || 1 x Penggunaan',
                                  style: blackvoucherTextStyle),
                              SizedBox(width: screenWidth / 20),
                            ],
                          ),
                          SizedBox(height: screenHeight / 78),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.DETAIL_VOUCHER_PAGE);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorResources.voucherbtnDetail,
                              minimumSize: Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              shadowColor: Colors.grey.withOpacity(0.5),
                              elevation: 5,
                            ),
                            child: Text('Detail Voucher',
                                style: whitevoucherTextStyle),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight / 70),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.ADD_VOUCHER_PAGE);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: ColorResources.primaryColorLight,
                  minimumSize: Size(screenWidth, screenHeight / 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.ticket),
                    SizedBox(width: 15),
                    Text('Buat Voucher Disini!'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
