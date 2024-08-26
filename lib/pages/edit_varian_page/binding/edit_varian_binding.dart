import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_varian_page/controller/edit_varian_controller.dart';

class EditVariantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVariantController>(() => EditVariantController());
  }
}