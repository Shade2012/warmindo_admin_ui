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
                                totalSales:
                                    controller.revenueChart.value.overalltotal ??
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
                                        if (controller.selectedInterval.value ==
                                            'monthly') {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              _getWeekNumber(value.toInt()),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        } else {
                                          final DateTime? date = controller
                                                  .isShowingRevenueChart.value
                                              ? revenueData[value.toInt()].date
                                              : salesData[value.toInt()].date;

                                          final formattedDate =
                                              _getFormattedDate(
                                                  date.toString(),
                                                  controller
                                                      .selectedInterval.value);

                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              formattedDate,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      reservedSize: 22,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 10000,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          '${value.toInt()}K',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
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
            toY: entry.value.total.toDouble(),
            color: Colors.black87,
            width: screenWidth * 0.035,
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
            toY: entry.value.total.toDouble(),
            color: Colors.black87,
            width: screenWidth * 0.035,
          ),
        ],
      );
    }).toList();
  }

  List<T> _filterDataByInterval<T>(List<T> data) {
    String interval = controller.selectedInterval.value;

    // Sort data by date, oldest first
    data.sort((a, b) {
      DateTime dateA = a is Datum ? a.date : (a as Sales).date;
      DateTime dateB = b is Datum ? b.date : (b as Sales).date;
      return dateA.compareTo(dateB);
    });

    if (interval == 'monthly') {
      // Group data into weeks
      List<T> week1 = [];
      List<T> week2 = [];
      List<T> week3 = [];
      List<T> week4 = [];
      List<T> week5 = [];

      data.forEach((item) {
        DateTime date = item is Datum ? item.date : (item as Sales).date;
        int day = date.day;

        if (day <= 7) {
          week1.add(item);
        } else if (day <= 14) {
          week2.add(item);
        } else if (day <= 21) {
          week3.add(item);
        } else if (day <= 28) {
          week4.add(item);
        } else {
          week5.add(item);
        }
      });

      // Aggregate totals for each week
      List<T> result = [];
      if (week1.isNotEmpty) result.add(_aggregateWeekData(week1));
      if (week2.isNotEmpty) result.add(_aggregateWeekData(week2));
      if (week3.isNotEmpty) result.add(_aggregateWeekData(week3));
      if (week4.isNotEmpty) result.add(_aggregateWeekData(week4));
      if (week5.isNotEmpty) result.add(_aggregateWeekData(week5));

      return result;
    } else {
      int limit = (interval == 'weekly') ? 7 : 12;
      DateTime now = DateTime.now();
      List<T> filteredData = data.where((item) {
        DateTime itemDate = item is Datum ? item.date : (item as Sales).date;
        return itemDate.isBefore(now) || itemDate.isAtSameMomentAs(now);
      }).toList();

      if (filteredData.length > limit) {
        return filteredData.sublist(filteredData.length - limit);
      }
      return filteredData;
    }
  }

  T _aggregateWeekData<T>(List<T> weekData) {
    if (T == Datum) {
      int total = weekData.fold(0, (sum, item) => sum + (item as Datum).total);
      DateTime date = (weekData.first as Datum).date;
      return Datum(total: total, date: date) as T;
    } else if (T == Sales) {
      int total = weekData.fold(0, (sum, item) => sum + (item as Sales).total);
      DateTime date = (weekData.first as Sales).date;
      return Sales(total: total, date: date) as T;
    } else {
      throw Exception('Unsupported type');
    }
  }

  String _getWeekNumber(int index) {
    switch (index) {
      case 0:
        return 'Minggu 1';
      case 1:
        return 'Minggu 2';
      case 2:
        return 'Minggu 3';
      case 3:
        return 'Minggu 4';
      case 4:
        return 'Minggu 5';
      default:
        return '';
    }
  }

  String _getFormattedDate(String? date, String interval) {
    if (date == null) {
      return '';
    }
    final date2 = DateTime.parse(date);
    if (interval == 'weekly') {
      return DateFormat.EEEE('id').format(date2);
    } else if (interval == 'monthly') {
      int dayOfMonth = date2.day;
      String weekNumber;
      if (dayOfMonth <= 7) {
        weekNumber = 'Minggu 1';
      } else if (dayOfMonth <= 14) {
        weekNumber = 'Minggu 2';
      } else if (dayOfMonth <= 21) {
        weekNumber = 'Minggu 3';
      } else if (dayOfMonth <= 28) {
        weekNumber = 'Minggu 4';
      } else {
        weekNumber = 'Minggu 5';
      }
      return weekNumber;
    } else if (interval == 'yearly') {
      return DateFormat.yMMM('id').format(date2);
    }
    return '';
  }
}
