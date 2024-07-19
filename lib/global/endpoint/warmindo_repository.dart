import 'package:warmindo_admin_ui/global/common/global_variables.dart';

final String apiUrl = GlobalVariables.apiUri;

class FoodApi {
  static AuthEndpoint auth = AuthEndpoint();
  static AllCustomers customers = AllCustomers();
  static OrderApi order = OrderApi();
  static var getallProductList = '$apiUrl/api/menus';
  static var getFoodList = '$apiUrl/api/menus/filter/makanan';
  static var getDrinkList = '$apiUrl/api/menus/filter/minuman';
  static var getSnackList = '$apiUrl/api/menus/filter/snack';
  static String storeProduct = '$apiUrl/api/menus/store';
  static String updateProduct = '$apiUrl/api/menus/';
  static String deleteProduct = '$apiUrl/api/menus';
}

class ToppingsApi {
  static var getallToppingsList = '$apiUrl/api/toppings';
  static var storeToppings = '$apiUrl/api/toppings/store';
  static var updateToppings = '$apiUrl/api/toppings/';
  static var deleteToppings = '$apiUrl/api/toppings';
  static var detailToppings = '$apiUrl/api/toppings/';
  
}

class VariantApi {
  static var getallVariantList = '$apiUrl/api/variants';
  static var storeVariant = '$apiUrl/api/variants/store';
  static var updateVariant = '$apiUrl/api/variants/';
  static var deleteVariant = '$apiUrl/api/variants';
  static var detailVariant = '$apiUrl/api/variants/';
}

class AuthEndpoint {
  final String login = '$apiUrl/api/admins/login';
}

class AllCustomers {
  final String customers = '$apiUrl/api/users/users';
  final String updateCustomers = '$apiUrl/api/users/update';
}

class OrderApi {
  static var getallOrderList = '$apiUrl/api/orders';
  static var editStatusOrder = '$apiUrl/api/orders/';
}