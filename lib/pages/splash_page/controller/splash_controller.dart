import 'package:get/get.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  Future<void> startTimer() async {
    await Future.delayed(Duration(seconds: 4));
    Get.offNamed(Routes.LOGIN_PAGE); 
  }
}
