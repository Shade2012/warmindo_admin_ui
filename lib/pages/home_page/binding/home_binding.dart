import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/home_page/controller/home_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}