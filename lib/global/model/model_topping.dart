class ToppingList {
  List<Topping> data;

  ToppingList({
    required this.data,
  });

  ToppingList copyWith({
    List<Topping>? data,
  }) => 
      ToppingList(
        data: data ?? this.data,
      );

  factory ToppingList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Topping> dataList = list.map((i) => Topping.fromJson(i)).toList();
    return ToppingList(data: dataList);
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((item) => item.toJson()).toList(),
      };
}

class Topping {
  int id;
  String nameTopping;
  int price;
  int stockTopping;
  int menuId;
  String status_topping;
  DateTime createdAt;
  DateTime updatedAt;

  Topping({
    required this.id,
    required this.nameTopping,
    required this.price,
    required this.stockTopping,
    required this.menuId,
    required this.status_topping,
    required this.createdAt,
    required this.updatedAt,
  });

  Topping copyWith({
    int? id,
    String? nameTopping,
    int? price,
    int? stockTopping,
    int? menuId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => 
      Topping(
        id: id ?? this.id,
        nameTopping: nameTopping ?? this.nameTopping,
        price: price ?? this.price,
        stockTopping: stockTopping ?? this.stockTopping,
        status_topping: status_topping,
        menuId: menuId ?? this.menuId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json['id'] ?? 0,
        nameTopping: json['name_topping'] ?? '',
        price: json['price'] ?? 0,
        stockTopping: int.tryParse(json['stock_topping'].toString()) ?? 0,
        status_topping: json['status_topping'] ?? '',
        menuId: int.tryParse(json['menu_id'].toString()) ?? 0,
        createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_topping': nameTopping,
        'price': price,
        'stock_topping': stockTopping,
        'status_topping': status_topping,
        'menu_id': menuId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
