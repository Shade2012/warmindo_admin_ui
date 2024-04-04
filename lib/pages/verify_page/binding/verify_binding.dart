import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/verify_page/controller/verify_controller.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}