import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/splash_page/controller/splash_controller.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Image.asset(
          Images.splashLogo,
          width: screenWidth * 0.5, 
          height: screenHeight * 0.5, 
        ),
      ),
    );
  }
}
