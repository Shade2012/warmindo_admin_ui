import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
    String status;
    String message;
    List<Order> orders;

    OrderList({
        required this.status,
        required this.message,
        required this.orders,
    });

    OrderList copyWith({
        String? status,
        String? message,
        List<Order>? orders,
    }) => 
        OrderList(
            status: status ?? this.status,
            message: message ?? this.message,
            orders: orders ?? this.orders,
        );

    factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        status: json["status"],
        message: json["message"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}

class Order {
    int id;
    String userId;
    String priceOrder;
    String status;
    dynamic note;
    DateTime createdAt;
    DateTime updatedAt;

    Order({
        required this.id,
        required this.userId,
        required this.priceOrder,
        required this.status,
        required this.note,
        required this.createdAt,
        required this.updatedAt,
    });

    Order copyWith({
        int? id,
        String? userId,
        String? priceOrder,
        String? status,
        dynamic note,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Order(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            priceOrder: priceOrder ?? this.priceOrder,
            status: status ?? this.status,
            note: note ?? this.note,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        priceOrder: json["price_order"],
        status: json["status"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "price_order": priceOrder,
        "status": status,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
