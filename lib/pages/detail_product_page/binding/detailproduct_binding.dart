import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/detail_product_page/controller/detailproduct_controller.dart';

class DetailProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductController>(
      () => DetailProductController(),
    );
  }
}