
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_customers_page/controller/edit_customers_controller.dart';

class EditCustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCustomersController>(() => EditCustomersController());
  }
} 