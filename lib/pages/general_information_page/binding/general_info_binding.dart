import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/controller/general_info_controller.dart';

class GeneralInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralInformationController>(() => GeneralInformationController());
  }
}