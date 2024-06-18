import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  final InternetService _internetService = InternetService();
  @override
  void onInit() {
    _internetService.connectionChange.listen(_updateConnectionStatus);
    _checkInternetConnection();
    // TODO: implement onInit
    super.onInit();
  }

  void _updateConnectionStatus(bool connected) {
    isConnected.value = connected;
    if (!isConnected.value) {
      isLoading.value = false;
    }
  }

  Future<void> _checkInternetConnection() async {
    isConnected.value = await _internetService.isConnected;
    if (isConnected.value) {
      //call fetch data here
    } else {
      isLoading.value = false;
    }
  }

}