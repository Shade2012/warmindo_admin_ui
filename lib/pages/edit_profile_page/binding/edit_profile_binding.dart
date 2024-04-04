import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/edit_profile_page/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}