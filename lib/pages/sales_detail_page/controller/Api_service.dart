import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/pages/sales_detail_page/model/revenue_model.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/model/sales_model.dart';

class ApiService {
  static const String baseUrl = "https://warmindoanggrekmuria.my.id/api";

  // Fungsi untuk mengambil data penjualan
  static Future<SalesChart> fetchSalesData(String interval) async {
    final response = await http.get(Uri.parse("$baseUrl/admins/chart-sales?interval=$interval"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return SalesChart(
        data: (jsonResponse['data'] as List).map((item) => Sales(
          total: item['total'],
          date: DateTime.parse(item['date']),
        )).toList(),
        overalltotal: jsonResponse['overall_total'],
      );
    } else if (response.statusCode == 404) {
      throw Exception('Resource not found');
    } else if (response.statusCode == 500) {
      throw Exception('Internal server error');
    } else {
      throw Exception('Failed to load sales data with status code: ${response.statusCode}');
    }
}


  // Fungsi untuk mengambil data pendapatan
  static Future<RevenueChart> fetchRevenueData(String interval) async {
    final response = await http.get(Uri.parse("$baseUrl/admins/chart-revenue?interval=$interval"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return RevenueChart(
        data: (jsonResponse['data'] as List).map((item) => Datum(
          total: item['total'],
          date: DateTime.parse(item['date'] as String),
        )).toList(),
        overalltotal: jsonResponse['overall_total'],
      );
    } else {
      throw Exception('Failed to load revenue data');
    }
  }
}
