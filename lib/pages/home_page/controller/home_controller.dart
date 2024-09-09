import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  final InternetService _internetService = InternetService();
  @override
  void onInit() {
    _internetService.connectionChange.listen(_updateConnectionStatus);
    _checkInternetConnection();
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

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Halo, Selamat Pagi';
    } else if (hour >= 12 && hour < 15) {
      return 'Halo, Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Halo, Selamat Sore';
    } else {
      return 'Halo, Selamat Malam';
    }
  }

}