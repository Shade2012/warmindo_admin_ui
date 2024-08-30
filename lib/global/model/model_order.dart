import 'dart:convert';
import 'package:warmindo_admin_ui/global/model/model_order_detail.dart';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  String status;
  String message;
  List<Order>? orders; // Updated to allow null

  OrderList({
    required this.status,
    required this.message,
    this.orders, // Allow null
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
        orders: json["orders"] != null
            ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "orders": orders != null
            ? List<dynamic>.from(orders!.map((x) => x.toJson()))
            : null,
      };
}

class Order {
  int id;
  String userId;
  String priceOrder;
  String status;
  String? note;
  String? paymentMethod; 
  String? orderMethod;   
  String? cancelMethod;
  String? reasonCancel;
  String? noRekening;
  String? adminFee;
  DateTime? createdAt;   
  DateTime? updatedAt;   
  List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.userId,
    required this.priceOrder,
    required this.status,
    this.note,
    this.paymentMethod,
    this.orderMethod,
    this.cancelMethod,
    this.reasonCancel,
    this.noRekening,
    this.adminFee,
    this.createdAt,
    this.updatedAt,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      priceOrder: json['price_order'] ?? '',
      status: json['status'],
      note: json['note'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      orderMethod: json['order_method'] ?? '',
      cancelMethod: json['cancel_method'] ?? '',
      reasonCancel: json['reason_cancel'] ?? '',
      noRekening: json['no_rekening'] ?? '',
      adminFee: json['admin_fee'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      orderDetails: (json['orderDetails'] as List)
          .map((item) => OrderDetail.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'price_order': priceOrder,
      'status': status,
      'note': note,
      'payment_method': paymentMethod,
      'order_method': orderMethod,
      'cancel_method': cancelMethod,
      'reason_cancel': reasonCancel,
      'no_rekening': noRekening,
      'admin_fee': adminFee,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'orderDetails': orderDetails.map((item) => item.toJson()).toList(),
    };
  }
}
