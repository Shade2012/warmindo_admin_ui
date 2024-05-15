import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/detail_voucher_page/controller/detail_voucher_controller.dart';

class DetailVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailVoucherController>(() => DetailVoucherController());
  }
}