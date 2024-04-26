import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/customers_page/controller/customers_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
  }
}