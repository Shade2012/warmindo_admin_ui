import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/controller/detail_order_controller.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderController>(() => DetailOrderController());
  }
}