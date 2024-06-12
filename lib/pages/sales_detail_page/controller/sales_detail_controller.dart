import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../model/sales_model.dart';

class SalesController extends GetxController {
  var dropdownValue = 'Mingguan'.obs;
  var selectedDate = DateTime.now().obs;
  var chartData = <SalesData>[].obs;
  var yAxisTitle = 'Total Penjualan'.obs;

  final _items = ['Mingguan', 'Bulanan', 'Tahunan'];

  List<String> get items => _items;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null).then((_) {
      updateChartData(type: 'Penjualan');
    });
  }

  void updateChartData({String type = 'Penjualan'}) {
    DateTime now = DateTime.now();
    print('Updating chart data for ${dropdownValue.value} with type $type');

    if (type == 'Penjualan') {
      yAxisTitle.value = 'Total Penjualan';
      if (dropdownValue.value == 'Mingguan') {
        chartData.value = List.generate(now.weekday, (index) {
          DateTime date = now.subtract(Duration(days: now.weekday - 1 - index));
          return SalesData(DateFormat('E', 'id_ID').format(date), (index + 1) * 10.0);
        });
      } else if (dropdownValue.value == 'Bulanan') {
        int weeksInMonth = (now.day / 7).ceil();
        chartData.value = List.generate(weeksInMonth, (index) {
          return SalesData('Minggu ${index + 1}', (index + 1) * 50.0);
        });
      } else {
        chartData.value = List.generate(now.month, (index) {
          DateTime date = DateTime(now.year, index + 1, 1);
          return SalesData(DateFormat('MMM', 'id_ID').format(date), (index + 1) * 100.0);
        });
      }
    } else if (type == 'Produk') {
      yAxisTitle.value = 'Jumlah Produk';
      if (dropdownValue.value == 'Mingguan') {
        chartData.value = List.generate(now.weekday, (index) {
          DateTime date = now.subtract(Duration(days: now.weekday - 1 - index));
          return SalesData(DateFormat('E', 'id_ID').format(date), (index + 1) * 8.0);
        });
      } else if (dropdownValue.value == 'Bulanan') {
        int weeksInMonth = (now.day / 7).ceil();
        chartData.value = List.generate(weeksInMonth, (index) {
          return SalesData('Minggu ${index + 1}', (index + 1) * 20.0);
        });
      } else {
        chartData.value = List.generate(now.month, (index) {
          DateTime date = DateTime(now.year, index + 1, 1);
          return SalesData(DateFormat('MMM', 'id_ID').format(date), (index + 1) * 40.0);
        });
      }
    }
    print('Chart data updated: ${chartData.length} items');
  }
}
