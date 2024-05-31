import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_topping_page/controller/add_topping_controller.dart';

class AddToppingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddToppingController>(() => AddToppingController());
  }
}
