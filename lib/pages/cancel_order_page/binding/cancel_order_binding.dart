import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/view/cancel_order_page.dart';

class canccelOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelOrderController>(() => CancelOrderController());
  }
}