import 'dart:convert';
OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));
String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
    bool success;
    String message;
    List<Order> data;

    OrderList({
        required this.success,
        required this.message,
        required this.data,
    });

    OrderList copyWith({
        bool? success,
        String? message,
        List<Order>? data,
    }) => 
        OrderList(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        success: json["success"],
        message: json["message"],
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Order {
    int orderId;
    String userId;
    String menuId;
    String priceOrder;
    DateTime orderDate;
    String status;
    String payment;
    String refund;
    dynamic note;
    DateTime createdAt;
    DateTime updatedAt;

    Order({
        required this.orderId,
        required this.userId,
        required this.menuId,
        required this.priceOrder,
        required this.orderDate,
        required this.status,
        required this.payment,
        required this.refund,
        required this.note,
        required this.createdAt,
        required this.updatedAt,
    });

    Order copyWith({
        int? orderId,
        String? userId,
        String? menuId,
        String? priceOrder,
        DateTime? orderDate,
        String? status,
        String? payment,
        String? refund,
        dynamic note,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Order(
            orderId: orderId ?? this.orderId,
            userId: userId ?? this.userId,
            menuId: menuId ?? this.menuId,
            priceOrder: priceOrder ?? this.priceOrder,
            orderDate: orderDate ?? this.orderDate,
            status: status ?? this.status,
            payment: payment ?? this.payment,
            refund: refund ?? this.refund,
            note: note ?? this.note,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        userId: json["user_id"], 
        menuId: json["menuID"],
        priceOrder: json["price_order"],
        orderDate: DateTime.parse(json["order_date"]),
        status: json["status"],
        payment: json["payment"],
        refund: json["refund"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "menuID": menuId,
        "price_order": priceOrder,
        "order_date": orderDate.toIso8601String(),
        "status": status,
        "payment": payment,
        "refund": refund,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
