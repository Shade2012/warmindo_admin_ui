import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_topping_page/controller/edit_topping_controller.dart';

class EditToppingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditToppingController>(() => EditToppingController());
  }
} 