import 'dart:convert';

VarianList varianListFromJson(String str) => VarianList.fromJson(json.decode(str));

String varianListToJson(VarianList data) => json.encode(data.toJson());

class VarianList {
    List<Datum> data;

    VarianList({
        required this.data,
    });

    VarianList copyWith({
        List<Datum>? data,
    }) => 
        VarianList(
            data: data ?? this.data,
        );

    factory VarianList.fromJson(Map<String, dynamic> json) => VarianList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
  int idVarian;
  String nameVarian;
  String category;
  String? image;  // Bisa null
  String stockVarian;

  Datum({
    required this.idVarian,
    required this.nameVarian,
    required this.category,
    this.image,  // Bisa null
    required this.stockVarian,
  });

  Datum copyWith({
    int? idVarian,
    String? nameVarian,
    String? category,
    String? image,
    String? stockVarian,
  }) => 
      Datum(
        idVarian: idVarian ?? this.idVarian,
        nameVarian: nameVarian ?? this.nameVarian,
        category: category ?? this.category,
        image: image ?? this.image,
        stockVarian: stockVarian ?? this.stockVarian,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idVarian: json["id_varian"],
    nameVarian: json["name_varian"],
    category: json["category"],
    image: json["image"],  // Bisa null
    stockVarian: json["stock_varian"],
  );

  Map<String, dynamic> toJson() => {
    "id_varian": idVarian,
    "name_varian": nameVarian,
    "category": category,
    "image": image,
    "stock_varian": stockVarian,
  };
}
