import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/input_notification_page/controller/input_notification_controller.dart';

class InputNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputNotificationController>(() => InputNotificationController());
  }
}