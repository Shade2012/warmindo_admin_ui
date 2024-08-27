import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/otp_page/controller/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
  
}