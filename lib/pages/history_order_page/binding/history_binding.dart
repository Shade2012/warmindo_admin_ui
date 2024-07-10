import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}