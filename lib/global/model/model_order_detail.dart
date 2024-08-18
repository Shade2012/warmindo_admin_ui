import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/global/model/model_topping.dart';
import 'package:warmindo_admin_ui/global/model/model_varian.dart';

class OrderDetail {
  int quantity;
  Menu menu;
  Datum? variant;
  List<Topping>? toppings;

  OrderDetail({
    required this.quantity,
    required this.menu,
    this.variant,
    this.toppings,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      quantity: json['quantity'] ?? 0,
      menu: Menu.fromJson(json['menu']),
      variant: json['variant'] != null
          ? Datum.fromJson(json['variant'])
          : null,
      toppings: (json['toppings'] as List)
          .map((item) => Topping.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'menu': menu.toJson(),
      'variant': variant?.toJson(),
      'toppings': toppings?.map((item) => item.toJson()).toList(),
    };
  }
}
