import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/order_page/controller/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}