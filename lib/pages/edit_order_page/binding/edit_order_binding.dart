import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/controller/edit_order_controller.dart';

class EditOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditOrderController>(() => EditOrderController());
  }
}