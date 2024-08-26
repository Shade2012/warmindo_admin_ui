class SalesChart {
  final List<Sales> data;
  final int? overalltotal;

  SalesChart({required this.data, required this.overalltotal});

  factory SalesChart.fromJson(Map<String, dynamic> json) {
    return SalesChart(
      data: (json['data'] as List).map((item) => Sales.fromJson(item)).toList(),
      overalltotal: json['overall_total'],
    );
  }
}
class Sales {
  final int total;
  final DateTime date;

  Sales({required this.total, required this.date});

  factory Sales.fromJson(Map<String, dynamic> json) {
    // Extract the date string
    String dateString = json['date'];

    // Check if the date string is in the 'YYYY-MM' format
    if (dateString.length == 7) { // YYYY-MM format
      // Append '-01' to make it 'YYYY-MM-DD'
      dateString = dateString + '-01';
    }

    // Parse the date
    DateTime parsedDate = DateTime.parse(dateString);

    // Return the Sales object
    return Sales(
      total: json['total'],
      date: parsedDate,
    );
  }
}
