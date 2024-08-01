import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/model/product_response.dart' as model;
import 'package:warmindo_admin_ui/global/model/topping_model.dart';
import 'package:warmindo_admin_ui/global/model/varian_model.dart';
import 'package:warmindo_admin_ui/global/services/intenet_service.dart';

class ProductController extends GetxController {
  var allProductList = <model.Menu>[].obs;
  var foodList = <model.Menu>[].obs;
  var drinklist = <model.Menu>[].obs;
  var snackList = <model.Menu>[].obs;
  var toppingList = <Topping>[].obs;
  var variantList = <Datum>[].obs;
  var selectedCategory = ''.obs;
  var filteredProductList = <model.Menu>[].obs;
  Timer? timer;
  RxBool isLoading = true.obs;
  final TextEditingController search = TextEditingController();
  RxString searchObx = ''.obs;
  RxBool isConnected = true.obs;
  RxList<model.Menu> searchResults = <model.Menu>[].obs;
  final InternetService _internetService = InternetService();

  @override
  void onInit() {
    super.onInit();
    _internetService.connectionChange.listen(_updateConnectionStatus);
    _checkInternetConnection();
    search.addListener(() {
      searchObx.value = search.text;
      searchFilter(search.text);
    });
  }

  void _updateConnectionStatus(bool connected) {
    isConnected.value = connected;
    if (!isConnected.value) {
      isLoading.value = false;
    }
  }

  Future<void> _checkInternetConnection() async {
    isConnected.value = await _internetService.isConnected;
    if (isConnected.value) {
      fetchAllData().then((_) {
        setCategory('Semua');
      });
    } else {
      isLoading.value = false;
    }
  }

  void searchFilter(String enteredKeyword) {
    if (enteredKeyword == '') {
      searchResults.clear();
    } else {
      enteredKeyword = enteredKeyword.toLowerCase();
      searchResults.assignAll(allProductList.where((product) {
        return product.nameMenu.toLowerCase().contains(enteredKeyword);
      }).toList());
      searchResults.addAll(toppingList.where((topping) {
        return topping.nameTopping.toLowerCase().contains(enteredKeyword);
      }).map((topping) => model.Menu(
          id: topping.id,
          nameMenu: topping.nameTopping,
          price: topping.price.toString(),
          image: '', 
          stock: topping.stockTopping.toString(),
          category: 'Topping',  
          ratings: '',
          description: '',
          createdAt: topping.createdAt,
          updatedAt: topping.updatedAt,
          secondCategory: topping.menuId.toString(),
      )).toList());
      searchResults.addAll(variantList.where((variant) {
        return variant.nameVarian.toLowerCase().contains(enteredKeyword);
      }).map((variant) => model.Menu(
          id: variant.idVarian,
          nameMenu: variant.nameVarian,
          price: '0', 
          image: variant.image ?? '', // Handle null value
          stock: variant.stockVarian,
          category: variant.category,  
          ratings: '',
          description: '',
          createdAt: DateTime.now(),  // Placeholder, update as needed
          updatedAt: DateTime.now(),  // Placeholder, update as needed
          secondCategory: '',
      )
      ).toList());
    }
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
          filterProducts();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      isLoading.value = false;
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
          filterProducts();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      isLoading.value = false;
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
          filterProducts();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      isLoading.value = false;
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
          filterProducts();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      isLoading.value = false;
      print('Selesai fetching data');
    }
  }

Future<void> getToppingList() async {
  isLoading.value = true;  // Set loading status before starting the fetch
  try {
    final response = await http.get(Uri.parse(ToppingsApi.getallToppingsList));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic>) {
        ToppingList toppingListData = ToppingList.fromJson(responseData);
        toppingList.value = toppingListData.data;
        filterProducts(); // Make sure this function is defined elsewhere
      } else {
        print('Data yang diterima tidak sesuai format yang diharapkan.');
      }
    } else {
      print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
    }
  } catch (error) {
    print("Error while fetching data: $error");
  } finally {
    isLoading.value = false;  // Set loading status after the fetch completes
    print('Selesai fetching data');
  }
}


  Future<void> getVariantList() async {
    try {
      final response = await http.get(Uri.parse(VariantApi.getallVariantList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData['data'] is List) {
          final List<dynamic> variantListData = responseData['data'];
          variantList.value =
              variantListData.map((json) => Datum.fromJson(json)).toList();
          filterProducts();
        } else {
          print('Data yang diterima tidak sesuai format yang diharapkan.');
        }
      } else {
        print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      isLoading.value = false;
      print('Selesai fetching data');
    }
  }

  void filterProducts() {
    if (selectedCategory.value == 'Semua') {
      filteredProductList.assignAll(allProductList);
      filteredProductList.addAll(toppingList.map((topping) => model.Menu(
        id: topping.id,
        nameMenu: topping.nameTopping,
        price: topping.price.toString(),
        image: '',
        stock: topping.stockTopping.toString(),
        category: 'Topping',  
        ratings: '',
        description: '',
        createdAt: topping.createdAt,
        updatedAt: topping.updatedAt,
        secondCategory: topping.menuId.toString(),
      )).toList());
      filteredProductList.addAll(variantList.map((variant) => model.Menu(
        id: variant.idVarian,
        nameMenu: variant.nameVarian,
        price: '', 
        image: variant.image ?? '', 
        stock: variant.stockVarian,
        category: 'Variant',  
        ratings: '',
        description: '',
        createdAt: DateTime.now(),  
        updatedAt: DateTime.now(),  
        secondCategory: variant.category,
      )).toList());
    } else if (selectedCategory.value == 'Makanan') {
      filteredProductList.assignAll(foodList);
    } else if (selectedCategory.value == 'Minuman') {
      filteredProductList.assignAll(drinklist);
    } else if (selectedCategory.value == 'Snack') {
      filteredProductList.assignAll(snackList);
    } else if (selectedCategory.value == 'Topping') {
      filteredProductList.assignAll(toppingList.map((topping) => model.Menu(
        id: topping.id,
        nameMenu: topping.nameTopping,
        price: topping.price.toString(),
        image: '', // Handle null value
        stock: topping.stockTopping.toString(),
        category: 'Topping',  // This is just an example, adjust accordingly
        ratings: '',
        description: '',
        createdAt: topping.createdAt,
        updatedAt: topping.updatedAt,
        secondCategory: topping.menuId.toString(),
      )).toList());
    } else if (selectedCategory.value == 'Varian') {
      filteredProductList.assignAll(variantList.map((variant) => model.Menu(
        id: variant.idVarian,
        nameMenu: variant.nameVarian,
        price: '', // You might need to update this according to your needs
        image: variant.image ?? '', // Handle null value
        stock: variant.stockVarian,
        category: 'Variant',  // This is just an example, adjust accordingly
        ratings: '',
        description: '',
        createdAt: DateTime.now(),  // Placeholder, update as needed
        updatedAt: DateTime.now(),  // Placeholder, update as needed
        secondCategory: '',
      )).toList());
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }

  Future<void> deleteProduct(int productId) async {
    isLoading.value = true;
    final String url = '${FoodApi.deleteProduct}/$productId';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        // Product deleted successfully
        Get.snackbar('Sukses', 'Produk berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await fetchAllData();
      } else {
        // Error from server
        // Get.snackbar('Error', 'Gagal menghapus produk',
            // snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Terjadi kesalahan',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteToppings(int toppingId) async {
    isLoading.value = true;
    final String url = '${ToppingsApi.deleteToppings}/$toppingId';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        // Topping deleted successfully
        Get.snackbar('Sukses', 'Topping berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await fetchAllData();
      } else {
        // Error from server
        // Get.snackbar('Error', 'Gagal menghapus topping',
        //     snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Terjadi kesalahan',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVariant(int idVarian) async {
    isLoading.value = true;
    final String url = '${VariantApi.deleteVariant}/$idVarian';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        // Variant deleted successfully
        Get.snackbar('Sukses', 'Variant berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await fetchAllData();
      } else {
        // Error from server
        // Get.snackbar('Error', 'Gagal menghapus variant',
        //     snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Terjadi kesalahan',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
