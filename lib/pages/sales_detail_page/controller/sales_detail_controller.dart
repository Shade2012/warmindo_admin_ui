import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/controller/Api_service.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/model/revenue_model.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/model/sales_model.dart';

class SalesController extends GetxController {
  var salesChart = SalesChart(data: [], overalltotal: 0).obs;
  var revenueChart = RevenueChart(data: [], overalltotal: 0).obs;
  var isLoading = false.obs;
  var selectedInterval = 'weekly'.obs;
  var isShowingRevenueChart = true.obs; // True untuk revenue, false untuk sales

  @override
  void onInit() {
    super.onInit();
    updateData(selectedInterval.value); // Inisialisasi dengan interval default
  }

  // Fetch sales data berdasarkan interval
  void fetchSalesData(String interval) async {
    isLoading.value = true;
    try {
      SalesChart fetchedSalesData = await ApiService.fetchSalesData(interval);
      salesChart.value = fetchedSalesData;
      print('Overall Total Sales: ${salesChart.value.overalltotal}');
    } catch (e) {
      print('Error fetching sales data: $e');
      salesChart.value = SalesChart(data: [], overalltotal: 0);
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch revenue data berdasarkan interval
  void fetchRevenueData(String interval) async {
    isLoading.value = true;
    try {
      RevenueChart fetchedRevenueData = await ApiService.fetchRevenueData(interval);
      revenueChart.value = fetchedRevenueData;
      print('Overall Total Revenue: ${revenueChart.value.overalltotal}');
    } catch (e) {
      print('Error fetching revenue data: $e');
      revenueChart.value = RevenueChart(data: [], overalltotal: 0);
    } finally {
      isLoading.value = false;
    }
  }

  // Update data based on dropdown selection
  void updateData(String interval) {
    selectedInterval.value = interval;
    fetchSalesData(interval);
    fetchRevenueData(interval);
  }

  // Show revenue chart
  void showRevenueChart() {
    isShowingRevenueChart.value = true;
  }

  // Show sales chart
  void showSalesChart() {
    isShowingRevenueChart.value = false;
  }
}
