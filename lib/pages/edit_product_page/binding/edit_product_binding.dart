import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_product_page/controller/edit_product_controller.dart';

class EditProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProductController>(() => EditProductController());
  }
}