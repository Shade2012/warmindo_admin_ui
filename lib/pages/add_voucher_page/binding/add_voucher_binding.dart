import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_voucher_page/controller/add_voucher_controller.dart';

class AddVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVoucherController>(() => AddVoucherController());
}
}