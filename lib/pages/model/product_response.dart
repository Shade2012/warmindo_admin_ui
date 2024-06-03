// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  Data data;

  ProductResponse({
    required this.data,
  });

  ProductResponse copyWith({
    Data? data,
  }) =>
      ProductResponse(
        data: data ?? this.data,
      );

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  bool success;
  String message;
  List<Menu> menu;

  Data({
    required this.success,
    required this.message,
    required this.menu,
  });

  Data copyWith({
    bool? success,
    String? message,
    List<Menu>? menu,
  }) =>
      Data(
        success: success ?? this.success,
        message: message ?? this.message,
        menu: menu ?? this.menu,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    message: json["message"],
    menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
  };
}

class Menu {
  int menuId;
  String image;
  String nameMenu;
  String price;
  String category;
  String secondCategory;
  String stock;
  String ratings;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Menu({
    required this.menuId,
    required this.image,
    required this.nameMenu,
    required this.price,
    required this.category,
    required this.stock,
    required this.ratings,
    required this.description,
    required this.secondCategory,
    required this.createdAt,
    required this.updatedAt,
  });

  Menu copyWith({
    int? menuId,
    String? image,
    String? nameMenu,
    String? price,
    String? category,
    String? secondCategory,
    String? stock,
    String? ratings,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Menu(
        menuId: menuId ?? this.menuId,
        image: image ?? this.image,
        nameMenu: nameMenu ?? this.nameMenu,
        price: price ?? this.price,
        category: category ?? this.category,
        stock: stock ?? this.stock,
        ratings: ratings ?? this.ratings,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        secondCategory: secondCategory ?? this.secondCategory,
      );

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuId: json["menuID"],
    image: json["image"],
    nameMenu: json["name_menu"],
    price: json["price"],
    category: json["category"],
    stock: json["stock"],
    ratings: json["ratings"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    secondCategory: json['second_category'],
  );

  Map<String, dynamic> toJson() => {
    "menuID": menuId,
    "image": image,
    "name_menu": nameMenu,
    "price": price,
    "category": category,
    "stock": stock,
    "ratings": ratings,
    "description": description,
    "second_category": secondCategory,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
