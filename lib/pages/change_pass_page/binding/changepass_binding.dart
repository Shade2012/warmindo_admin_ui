import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/change_pass_page/controller/changepass_controller.dart';

class ChangePassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePassController>(() => ChangePassController());
  }
}