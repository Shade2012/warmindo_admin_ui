import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  Future<void> startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Future.delayed(Duration(seconds: 4));
    if (token == null) {
      Get.offAllNamed(Routes.LOGIN_PAGE);
    } else {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    }
  }
}
