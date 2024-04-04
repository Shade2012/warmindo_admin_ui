import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/setting_page/controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}