import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/ChangePassword_page/controller/change_password_controller.dart';

class ChangePassBin extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassController>(() => ForgotPassController());
  }
  
}