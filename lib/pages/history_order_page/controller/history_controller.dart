import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/model/history_order_model.dart';

class HistoryController extends GetxController {
  RxBool isConnection = false.obs;
  RxBool isLoading = true.obs;
  RxList<Order> orders = <Order>[].obs;
  RxString status = ''.obs;
  RxString selectedCategory = 'Semua'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeOrders();
  }

  void initializeOrders() {
    orders.assignAll(orderList);
  }

  List<Order> getOrdersByStatus(String status) {
    return orders.where((o) => o.status.toLowerCase() == status.toLowerCase()).toList();
  }

  List<Order> filteredHistory() {
    if (selectedCategory.value == null || selectedCategory.value == 'Semua') {
      return orders;
    } else {
      return orders
          .where((order) => order.status == selectedCategory.value)
          .toList();
    }
  }

  String leadingImageChange(String status){
    if (status == 'Selesai') {
      return Images.pesanan_selesai;
    } else if (status == 'Sedang Diproses') {
      return Images.sedangDiproses;
    } else if (status == 'Menunggu Batal') {
      return Images.menungguBatal;
    } else if (status == 'Batal') {
      return Images.batal;
    } else {
      return Images.pesananSiap;
    }
  }
}