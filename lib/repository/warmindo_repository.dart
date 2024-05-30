import 'package:warmindo_admin_ui/common/global_variables.dart';

class FoodApi {
  static String apiUrl = GlobalVariables.apiUrl;
  static var getallProductList = '$apiUrl/api/menus';
  static var getFoodList = '$apiUrl/api/menus/filter/makanan';
  static var getDrinkList = '$apiUrl/api/menus/filter/minuman';
  static var getSnackList = '$apiUrl/api/menus/filter/snack';
  static var getToppingList = '$apiUrl/api/menus/filter/topping';
  static var getVariantList = '$apiUrl/api/menus/filter/varian';
  static var addMenu = '$apiUrl/api/menus/store';
  static var updateMenu = '$apiUrl/api/menus/id';
}