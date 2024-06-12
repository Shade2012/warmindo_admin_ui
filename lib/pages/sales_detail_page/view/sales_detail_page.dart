import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/controller/sales_detail_controller.dart';
import 'package:warmindo_admin_ui/pages/widget/analyticBox.dart';
import 'package:warmindo_admin_ui/utils/themes/icon_themes.dart';
import '../model/sales_model.dart';

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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
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
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                          text: 'Waktu',
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                          text: controller.yAxisTitle.value,
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        activationMode: ActivationMode.singleTap,
                        lineType: TrackballLineType.vertical,
                        tooltipSettings: InteractiveTooltip(
                          enable: true,
                          color: Colors.red,
                        ),
                      ),
                      legend: Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.bottom,
                      ),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          dataSource: controller.chartData,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: Colors.black,
                          animationDuration: 0,
                          name: 'Sales Data',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
