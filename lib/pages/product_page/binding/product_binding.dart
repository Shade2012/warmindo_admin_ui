import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}