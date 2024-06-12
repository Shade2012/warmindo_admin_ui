import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class AnalyticBox extends StatelessWidget {
  const AnalyticBox({
    Key? key,
    required this.totalSales,
    required this.titleAnalyticBox,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  final int totalSales;
  final String titleAnalyticBox;
  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    String formattedTotalSales = _formatTotalSales(totalSales);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ColorResources.analyticBoxColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(2.0, 5.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$titleAnalyticBox',
              style: headerAnalyticBoxTextStyle,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedTotalSales,
                  style: valueAnalyticBoxTextStyle,
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  imagePath,
                  width: 40.0,
                  height: 40.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTotalSales(int totalSales) {
    if (totalSales >= 1000000) {
      double formattedValue = totalSales / 1000000;
      String formattedString = formattedValue.toString();
      formattedString = formattedString.replaceAll(RegExp(r'\.0+$'), '');
      return '$formattedString JT';
    } else {
      return NumberFormat.compact().format(totalSales);
    }
  }
}
