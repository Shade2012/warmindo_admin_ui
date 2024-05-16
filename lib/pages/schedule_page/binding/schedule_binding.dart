import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/schedule_page/controller/schedule_controller.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());
  }
}