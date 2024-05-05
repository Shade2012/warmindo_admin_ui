import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/controller/cancel_order_controller.dart';

class canccelOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelOrderController>(() => CancelOrderController());
  }
}