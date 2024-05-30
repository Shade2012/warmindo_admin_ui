import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/model/product_response.dart' as model;
import 'package:warmindo_admin_ui/repository/warmindo_repository.dart';

class ApiController extends GetxController {
  var allProductList = <model.Menu>[].obs;
  var foodList = <model.Menu>[].obs;
  var drinklist = <model.Menu>[].obs;
  var snackList = <model.Menu>[].obs;
  var toppingList = <model.Menu>[].obs;
  var variantList = <model.Menu>[].obs;
  var selectedCategory = ''.obs;
  var filteredProductList = <model.Menu>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData().then((_) {
      setCategory('Semua');
    });
  }

  Future<void> fetchAllData() async {
    await Future.wait([
      getAllProductList(),
      getFoodList(),
      getDrinkList(),
      getSnackList(),
      getToppingList(),
      getVariantList(),
    ]);
  }

  Future<void> getAllProductList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getallProductList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData['menu'] is List) {
          final List<dynamic> allProductListData = responseData['menu'];
          allProductList.value = allProductListData
              .map((json) => model.Menu.fromJson(json))
              .toList();
          filteredProductList();
          print(allProductListData[0]['name_menu']);
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data');
    }
  }

  Future<void> getFoodList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getFoodList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData['menu'] is List) {
          final List<dynamic> foodListData = responseData['menu'];
          foodList.value =
              foodListData.map((json) => model.Menu.fromJson(json)).toList();
          filteredProductList();
          print(foodListData[0]['name_menu']);
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else if (response.statusCode == 404) {
        print('Resource not found. Status code: 404');
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data');
    }
  }

  Future<void> getDrinkList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getDrinkList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data']['menu'] is List) {
          final List<dynamic> drinkListData = responseData['data']['menu'];
          drinklist.value =
              drinkListData.map((json) => model.Menu.fromJson(json)).toList();
          filteredProductList();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else if (response.statusCode == 404) {
        print('Resource not found. Status code: 404');
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data');
    }
  }

  Future<void> getSnackList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getSnackList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data']['menu'] is List) {
          final List<dynamic> snackListData = responseData['data']['menu'];
          snackList.value =
              snackListData.map((json) => model.Menu.fromJson(json)).toList();
          filteredProductList();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else if (response.statusCode == 404) {
        print('Resource not found. Status code: 404');
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data');
    }
  }

  Future<void> getToppingList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getToppingList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data']['menu'] is List) {
          final List<dynamic> toppingListData = responseData['data']['menu'];
          toppingList.value =
              toppingListData.map((json) => model.Menu.fromJson(json)).toList();
          filteredProductList();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else if (response.statusCode == 404) {
        print('Resource not found. Status code: 404');
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data');
    }
  }

  Future<void> getVariantList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getVariantList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data']['menu'] is List) {
          final List<dynamic> variantListData = responseData['data']['menu'];
          variantList.value =
              variantListData.map((json) => model.Menu.fromJson(json)).toList();
          filteredProductList();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else if (response.statusCode == 404) {
        print('Resource not found. Status code: 404');
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Selesai fetching data');
    }
  }

  void filterProducts() {
    if (selectedCategory.value == 'Semua') {
      filteredProductList.assignAll(allProductList);
    } else if (selectedCategory.value == 'Makanan') {
      filteredProductList.assignAll(foodList);
    } else if (selectedCategory.value == 'Minuman') {
      filteredProductList.assignAll(drinklist);
    } else if (selectedCategory.value == 'Snack') {
      filteredProductList.assignAll(snackList);
    } else if (selectedCategory.value == 'Topping') {
      filteredProductList.assignAll(toppingList);
    } else if (selectedCategory.value == 'Varian') {
      filteredProductList.assignAll(variantList);
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }
}
