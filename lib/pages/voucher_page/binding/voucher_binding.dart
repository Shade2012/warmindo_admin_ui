import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/voucher_page/controller/voucher_controller.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherController>(() => VoucherController());
  }
}