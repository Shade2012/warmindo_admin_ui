import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';
import 'package:warmindo_admin_ui/global/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/controller/sales_detail_controller.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/model/revenue_model.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/model/sales_model.dart';

class SalesDetailPage extends StatelessWidget {
  SalesDetailPage({Key? key}) : super(key: key);
  final SalesController controller = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('Detail Penjualan'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: AnalyticBox(
                                totalSales: controller
                                        .revenueChart.value.overalltotal ??
                                    0,
                                titleAnalyticBox: 'Total Penjualan',
                                imagePath: IconThemes.iconCoin,
                                onTap: () {
                                  controller.showRevenueChart();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: AnalyticBox(
                                totalSales:
                                    controller.salesChart.value.overalltotal ??
                                        0,
                                titleAnalyticBox: 'Total Produk Terjual',
                                imagePath: IconThemes.iconProduct,
                                onTap: () {
                                  controller.showSalesChart();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Statistik',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.27,
                              height: screenHeight * 0.05,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'weekly',
                                      child: Text('Mingguan'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'monthly',
                                      child: Text('Bulanan'),
                                    ),
                                    // DropdownMenuItem<String>(
                                    //   value: 'yearly',
                                    //   child: Text('Tahunan'),
                                    // ),
                                  ],
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.updateData(newValue);
                                    }
                                  },
                                  value: controller.selectedInterval.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Obx(() {
                            final List<Datum> revenueData =
                                controller.revenueChart.value.data ?? [];
                            final List<Sales> salesData =
                                controller.salesChart.value.data ?? [];

                            final barGroups =
                                controller.isShowingRevenueChart.value
                                    ? _generateBarGroupsFromDatum(
                                        revenueData, screenWidth)
                                    : _generateBarGroupsFromSales(
                                        salesData, screenWidth);

                            final String leftTitle =
                                controller.isShowingRevenueChart.value
                                    ? 'Total Penjualan'
                                    : 'Total Produk Terjual';

                            return BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        final DateTime? date = controller
                                                .isShowingRevenueChart.value
                                            ? revenueData[value.toInt()].date
                                            : salesData[value.toInt()].date;
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            _getFormattedDate(
                                                 date.toString(),
                                                controller
                                                    .selectedInterval.value),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        );
                                      },
                                      reservedSize: 28,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                      getTitlesWidget: (value, meta) {
                                        return SideTitleWidget(
                                          angle: 0,
                                          space: 0,
                                          axisSide: meta.axisSide,
                                          child: Text(
                                            leftTitle,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        );
                                      },
                                      reservedSize: 50,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: barGroups,
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipRoundedRadius: 8,
                                    tooltipPadding: const EdgeInsets.all(8),
                                    getTooltipItem:
                                        (group, groupIndex, rod, rodIndex) {
                                      final DateTime? date =
                                          controller.isShowingRevenueChart.value
                                              ? revenueData[groupIndex].date
                                              : salesData[groupIndex].date;
                                      return BarTooltipItem(
                                        rod.toY.toStringAsFixed(0),
                                        TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          // TextSpan(
                                          //   text:
                                          //       ' ${_getFormattedDate(date, controller.selectedInterval.value)}',
                                          //   style: TextStyle(
                                          //     color: Colors.black54,
                                          //   ),
                                          // ),
                                        ],
                                      );
                                    },
                                    getTooltipColor: (barChartGroupData) =>
                                        Colors.white,
                                    tooltipMargin: 10,
                                    fitInsideVertically: true,
                                    fitInsideHorizontally: true,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  List<BarChartGroupData> _generateBarGroupsFromDatum(
    List<Datum> data, double screenWidth) {
    List<Datum> filteredData = _filterDataByInterval(data);

    return filteredData.asMap().entries.map<BarChartGroupData>((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.total?.toDouble() ?? 0,
            color: Colors.black87,
            width: screenWidth * 0.06,
          ),
        ],
      );
    }).toList();
  }

  List<BarChartGroupData> _generateBarGroupsFromSales(
      List<Sales> data, double screenWidth) {
    List<Sales> filteredData = _filterDataByInterval(data);

    return filteredData.asMap().entries.map<BarChartGroupData>((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.total?.toDouble() ?? 0,
            color: Colors.black87,
            width: screenWidth * 0.06,
          ),
        ],
      );
    }).toList();
  }

  List<T> _filterDataByInterval<T>(List<T> data) {
    String interval = controller.selectedInterval.value;
    int limit = 0;

    if (interval == 'weekly') {
      limit = 7;
    } else if (interval == 'monthly') {
      limit = 4;
    } else if (interval == 'yearly') {
      limit = 12;
    }

    // Sort data by date, oldest first
    data.sort((a, b) {
      DateTime dateA = a is Datum ? a.date : (a as Sales).date;
      DateTime dateB = b is Datum ? b.date : (b as Sales).date;
      return dateA.compareTo(dateB);
    });

    // Use DateTime.now() to filter data up to the current date
    DateTime now = DateTime.now();
    List<T> filteredData = data.where((item) {
      DateTime itemDate = item is Datum ? item.date : (item as Sales).date;
      return itemDate.isBefore(now) || itemDate.isAtSameMomentAs(now);
    }).toList();

    // Limit the number of data points based on the interval
    if (filteredData.length > limit) {
      return filteredData.sublist(filteredData.length - limit);
    }

    return filteredData;
  }

  String _getFormattedDate(String? date, String interval) {
    if (date == null) {
      return '';
    }
    if (interval == 'weekly') {
      // Format menjadi hari (Senin, Selasa, dll.)
      final date2 = DateTime.parse(date);
      return DateFormat.EEEE('id').format(date2);
    } else if (interval == 'monthly') {
      final date2 = DateTime.parse(date);
      // Format menjadi "Minggu 1", "Minggu 2", dll.
      int weekOfMonth = ((date2.day -1) / 7).floor();
      // return 'Minggu $weekOfMonth';
      if (weekOfMonth > 4) {
        weekOfMonth = 4;
      }
      return 'Minggu $weekOfMonth';

    } else if (interval == 'yearly') {
      // Format menjadi bulan (Januari, Februari, dll.)
      String dateWithDay = date + "-01";
    final date2 = DateTime.parse(dateWithDay);
    // Format menjadi bulan (Januari, Februari, dll.)
    return DateFormat.yMMM('id').format(date2);
    }
    return '';
  }
}
