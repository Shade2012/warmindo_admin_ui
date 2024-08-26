class RevenueChart {
  final List<Datum> data;
  final int? overalltotal;

  RevenueChart({required this.data, required this.overalltotal});

  factory RevenueChart.fromJson(Map<String, dynamic> json) {
    return RevenueChart(
      data: (json['data'] as List).map((item) => Datum.fromJson(item)).toList(),
      overalltotal: json['overall_total'], 
    );
  }
}

class Datum {
  final int total;
  final DateTime date;

  Datum({required this.total, required this.date});

  factory Datum.fromJson(Map<String, dynamic> json) {
    String dateString = json['date'];
     if (dateString.length == 7) { // YYYY-
   // Append '-01' to make it 'YYYY-MM-
   dateString = dateString + '-01';
 }
  DateTime parsedDate = DateTime.parse(dateString);
    return Datum(
      total: json['total'],
      date: parsedDate,
    );
  }
}
