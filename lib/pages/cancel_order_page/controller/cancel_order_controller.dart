import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';
import 'package:http/http.dart' as http;

class CancelOrderController extends GetxController{
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
      //Fetch data here
    } else {
      isLoading.value = false;
    }
  }

  Future<void> acceptCancel(int id) async {
  isLoading.value = true;
  final String url = '${OrderApi.acceptcancel}$id';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar('Sukses', 'Pesanan berhasil dibatalkan', snackPosition: SnackPosition.TOP);
    } else {
      print('Gagal membatalkan pesanan. Status respon: ${response.statusCode}');
    }
  } catch (e) {
    Get.snackbar('Error', 'Terjadi kesalahan', snackPosition: SnackPosition.TOP);
  } finally {
    isLoading.value = false;
  }
}

Future<void> rejectCancel(int id) async {
  isLoading.value = true;
  final String url = '${OrderApi.rejectcancel}$id';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar('Sukses', 'status berhasil diubah', snackPosition: SnackPosition.TOP);
    } else {
      print('Gagal membatalkan pesanan. Status respon: ${response.statusCode}');
    }
  } catch (e) {
    Get.snackbar('Error', 'Terjadi kesalahan', snackPosition: SnackPosition.TOP);
  } finally {
    isLoading.value = false;
  }
}  
}