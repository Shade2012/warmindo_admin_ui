import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class SplashController extends GetxController {
  final NavigatorController controller = Get.put(NavigatorController());
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  Future<void> startTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Future.delayed(Duration(seconds: 2));
    controller.currentIndex.value = 0;
    if (token == null) {
      Get.offAllNamed(Routes.LOGIN_PAGE);
    } else {
      Get.find<NavigatorController>().goToHomePage();
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      
    }
  }
}
