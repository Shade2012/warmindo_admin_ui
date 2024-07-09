import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/history_detail_page/controller/detail_history_controller.dart';

class DetailHistoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailHistoryController>(() => DetailHistoryController());
  }
}