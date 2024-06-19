import 'package:warmindo_admin_ui/global/common/global_variables.dart';

final String apiUrl = GlobalVariables.apiUri;
class FoodApi {
  static AuthEndpoint auth = AuthEndpoint();
  static AllCustomers customers = AllCustomers();
  static var getallProductList = '$apiUrl/api/menus';
  static var getFoodList = '$apiUrl/api/menus/filter/makanan';
  static var getDrinkList = '$apiUrl/api/menus/filter/minuman';
  static var getSnackList = '$apiUrl/api/menus/filter/snack';
  static var getToppingList = '$apiUrl/api/menus/filter/topping';
  static var getVariantList = '$apiUrl/api/menus/filter/varian';
  static String storeProduct = '$apiUrl/api/menus/store';
  static String updateProduct = '$apiUrl/api/menus/';
  static String deleteProduct = '$apiUrl/api/menus';
}

class AuthEndpoint {
  final String login = '$apiUrl/api/admins/login';
}

class AllCustomers {
  final String customers = '$apiUrl/api/users/users';
}