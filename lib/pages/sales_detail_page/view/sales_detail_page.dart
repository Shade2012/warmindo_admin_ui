import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/controller/sales_detail_controller.dart';
import 'package:warmindo_admin_ui/global/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';

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
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: AnalyticBox(
                          totalSales: 200000,
                          titleAnalyticBox: 'Total Penjualan',
                          imagePath: IconThemes.iconCoin,
                          onTap: () {
                            controller.updateChartData(type: 'Penjualan');
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: AnalyticBox(
                          totalSales: 50,
                          titleAnalyticBox: 'Produk',
                          imagePath: IconThemes.iconProduct,
                          onTap: () {
                            controller.updateChartData(type: 'Produk');
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
                      Row(
                        children: [
                          Container(
                            width: screenWidth * 0.27,
                            height: screenHeight * 0.05,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                items: controller.items.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropdownValue.value = newValue!;
                                  controller.updateChartData();
                                },
                                value: controller.dropdownValue.value,
                                selectedItemBuilder: (BuildContext context) {
                                  return controller.items
                                      .map<Widget>((String value) {
                                    return Center(child: Text(value));
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.chartData[value.toInt()].year,
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
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value == meta.min) {
                                  return SideTitleWidget(
                                    angle: 0,
                                    space: 0,
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      controller.yAxisTitle.value,
                                      style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                              reservedSize: 50,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: controller.chartData
                            .asMap()
                            .entries
                            .map((entry) => BarChartGroupData(
                                  x: entry.key,
                                  barRods: [
                                    BarChartRodData(
                                      toY: entry.value.sales,
                                      color: Colors.black87,
                                      width: screenWidth * 0.06,
                                    ),
                                  ],
                                ))
                            .toList(),
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipRoundedRadius: 8,
                            tooltipPadding: const EdgeInsets.all(8),
                            getTooltipItem: (
                              group,
                              groupIndex,
                              rod,
                              rodIndex,
                            ) {
                              return BarTooltipItem(
                                rod.toY.toStringAsFixed(0),
                                TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        ' ${controller.chartData[groupIndex].year}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
