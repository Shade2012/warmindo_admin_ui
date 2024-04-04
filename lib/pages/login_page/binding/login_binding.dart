import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/login_page/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}