import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/controller/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(() => AddProductController());
  }
}