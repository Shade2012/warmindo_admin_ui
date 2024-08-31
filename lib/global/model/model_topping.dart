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
  final List<MenuTopping> menus;
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
    required this.menus
  });

  Topping copyWith({
    int? id,
    String? nameTopping,
    int? price,
    int? stockTopping,
    int? menuId,
    required final List<MenuTopping> menus,
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
        updatedAt: updatedAt ?? this.updatedAt, menus: [],
      );

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        id: json['id'] ?? 0,
        nameTopping: json['name_topping'] ?? '',
        price: json['price'] ?? 0,
        stockTopping: int.tryParse(json['stock'].toString()) ?? 0,
        status_topping: json['status_topping'] ?? '',
        menuId: int.tryParse(json['menu_id'].toString()) ?? 0,
        createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),     menus: json["menus"] != null
      ? List<MenuTopping>.from(json["menus"].map((x) => MenuTopping.fromJson(x)))
      : [], //
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
class MenuTopping {
  final int menuID;
  final String menuName;

  MenuTopping({
    required this.menuID,
    required this.menuName,
  });

  // Factory constructor to parse JSON data
  factory MenuTopping.fromJson(Map<String, dynamic> json) => MenuTopping(
    menuID: json["menu_id"],
    menuName: json["menu_name"],
  );

  // Method to convert Menu object to JSON
  Map<String, dynamic> toJson() => {
    "menu_id": menuID,
    "menu_name": menuName,
  };

  @override
  String toString() {
    return 'MenuTopping(menuID: $menuID, menuName: $menuName)';
  }
}
