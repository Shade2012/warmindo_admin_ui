import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/global/model/model_topping.dart';

class MenuOrTopping {
  final String name;
  final String stock;
  final double price;

  MenuOrTopping.fromMenu(Menu menu)
      : name = menu.nameMenu,
        stock = menu.stock,
        price = double.parse(menu.price);

  MenuOrTopping.fromTopping(Topping topping)
      : name = topping.nameTopping,
        stock = topping.stockTopping,
        price = topping.price.toDouble();
}
