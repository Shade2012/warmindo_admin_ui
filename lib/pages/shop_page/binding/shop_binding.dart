import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/shop_page/controller/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController());
  }
}