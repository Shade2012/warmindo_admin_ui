import 'package:get/get.dart';
import '../controller/detail_customers_controller.dart';

class DetailCustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCustomersController>(() => DetailCustomersController());
  }
}