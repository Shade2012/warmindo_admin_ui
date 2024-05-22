import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_varian_page/controller/add_varian_controller.dart';

class AddVarianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddVarianController());
  }
}
