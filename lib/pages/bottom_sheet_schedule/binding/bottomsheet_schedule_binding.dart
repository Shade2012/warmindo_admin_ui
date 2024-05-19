import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/controller/bottomsheet_schedule_controller.dart';

class BottomSheetScheduleBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BottomSheetScheduleController>(() => BottomSheetScheduleController());
  }
}