import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/splash_page/controller/splash_controller.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Image.asset(
          Images.splashLogo,
          width: 220,
          height: 220,
        ),
      ),
    );
  }
}
