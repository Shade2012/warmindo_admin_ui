class ProductResponse {
    Data data;

    ProductResponse({
        required this.data,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };

    ProductResponse copyWith({
        Data? data,
    }) => 
        ProductResponse(
            data: data ?? this.data,
        );
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
}

class Menu {
    int id;
    String image;
    String nameMenu;
    String price;
    String category;
    String secondCategory;
    String stock;
    double? rating;
    String description;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    Menu({
        required this.id,
        required this.image,
        required this.nameMenu,
        required this.price,
        required this.category,
        required this.secondCategory,
        required this.stock,
        this.rating,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        image: json["image"] ?? '',
        nameMenu: json["name_menu"] ?? '',
        price: json["price"] ?? '',
        category: json["category"] ?? '',
        secondCategory: json["second_category"] ?? '',
        stock: json["stock"] ?? '',
        rating: double.tryParse(json["average_rating"] ?? '0') ?? 0.0,
        description: json["description"] ?? '',
        status: json["status_menu"] ?? 'Available',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name_menu": nameMenu,
        "price": price,
        "category": category,
        "second_category": secondCategory,
        "stock": stock,
        "rating": rating.toString(),
        "description": description,
        "status_menu": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    Menu copyWith({
        int? id,
        String? image,
        String? nameMenu,
        String? price,
        String? category,
        String? secondCategory,
        String? stock,
        double? rating,
        String? description,
        String? status_menu,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Menu(
            id: id ?? this.id,
            image: image ?? this.image,
            nameMenu: nameMenu ?? this.nameMenu,
            price: price ?? this.price,
            category: category ?? this.category,
            secondCategory: secondCategory ?? this.secondCategory,
            stock: stock ?? this.stock,
            rating: rating ?? this.rating,
            description: description ?? this.description,
            status: status_menu ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
}
