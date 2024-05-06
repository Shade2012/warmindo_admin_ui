import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/controller/sales_detail_controller.dart';

class SalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesController>(() => SalesController());
  }
}