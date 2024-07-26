import 'dart:convert';

ToppingList toppingListFromJson(String str) => ToppingList.fromJson(json.decode(str));

String toppingListToJson(ToppingList data) => json.encode(data.toJson());

class ToppingList {
    Data data;

    ToppingList({
        required this.data,
    });

    ToppingList copyWith({
        Data? data,
    }) => 
        ToppingList(
            data: data ?? this.data,
        );

    factory ToppingList.fromJson(Map<String, dynamic> json) => ToppingList(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    bool success;
    String message;
    List<Topping> menu;

    Data({
        required this.success,
        required this.message,
        required this.menu,
    });

    Data copyWith({
        bool? success,
        String? message,
        List<Topping>? menu,
    }) => 
        Data(
            success: success ?? this.success,
            message: message ?? this.message,
            menu: menu ?? this.menu,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        message: json["message"],
        menu: List<Topping>.from(json["menu"].map((x) => Topping.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
    };
}

class Topping {
    int toppingId;
    String nameTopping;
    String price;
    String image;
    String stock;
    DateTime createdAt;
    DateTime updatedAt;

    Topping({
        required this.toppingId,
        required this.nameTopping,
        required this.price,
        required this.image,
        required this.stock,
        required this.createdAt,
        required this.updatedAt,
    });

    Topping copyWith({
        int? toppingId,
        String? nameTopping,
        String? price,
        String? image,
        String? stock,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Topping(
            toppingId: toppingId ?? this.toppingId,
            nameTopping: nameTopping ?? this.nameTopping,
            price: price ?? this.price,
            image: image ?? this.image,
            stock: stock ?? this.stock,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        toppingId: json["topping_id"],
        nameTopping: json["name_topping"],
        price: json["price"],
        image: json["image"],
        stock: json["stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "topping_id": toppingId,
        "name_topping": nameTopping,
        "price": price,
        "image": image,
        "stock": stock,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
