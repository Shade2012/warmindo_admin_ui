import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class SettingsController extends GetxController {
  RxString email = ''.obs;
  RxString password = ''.obs;
  late final SharedPreferences prefs;

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  void checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('email') ?? '';
    password.value = prefs.getString('password') ?? '';
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('email');
    prefs.remove('password');
    Get.offAllNamed(Routes.SPLASH_PAGE);
  }
}