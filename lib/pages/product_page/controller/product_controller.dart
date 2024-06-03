import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/data/api_controller.dart';
import 'package:warmindo_admin_ui/repository/warmindo_repository.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  final ApiController apiController = Get.find<ApiController>();

  Future<void> deleteProduct(int productId) async {
    isLoading.value = true;
    final String url = '${FoodApi.deleteProduct}/$productId';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        // Product deleted successfully
        Get.snackbar('Sukses', 'Produk berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await apiController.fetchAllData();
      } else {
        // Error from server
        Get.snackbar('Error', 'Gagal menghapus produk',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Terjadi kesalahan',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
