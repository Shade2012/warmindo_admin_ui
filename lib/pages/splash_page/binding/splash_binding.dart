import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/splash_page/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}