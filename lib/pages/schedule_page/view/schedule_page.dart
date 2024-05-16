import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
        title: Text('Jadwal Restoran'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, 
            vertical: screenHeight * 0.03, 
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.datePicker),
              SizedBox(height: screenHeight * 0.02), // 2% dari tinggi layar
              Text(
                'Memperkenalkan Jadwal Khusus',
                textAlign: TextAlign.center,
                style: scheduleTitleTextStyle,
              ),
              SizedBox(height: screenHeight * 0.01), 
              Text(
                'Tambahkan jam buka khusus untuk libur nasional atau libur lainnya',
                textAlign: TextAlign.center,
                style: scheduleContentTextStyle,
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  foregroundColor: ColorResources.primaryColorLight,
                  minimumSize: Size(screenWidth * 0.6, 50), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text('Tambah Jadwal Khusus'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
