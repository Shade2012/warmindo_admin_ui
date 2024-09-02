import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart' as model;
import 'package:warmindo_admin_ui/global/model/model_topping.dart';
import 'package:warmindo_admin_ui/global/model/model_varian.dart';
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
  RxList<int> selectedMenuIds = <int>[].obs;
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
  void updateSelection() {
    selectedMenuIds.value = foodList.where((item) => item.isSelected.value).map((item) => item.id).toList();
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
        rating: 0.0,
        description: topping.menus.map((menu) => menu.menuID).join(', '),
        status: topping.status_topping,
        createdAt: topping.createdAt,
        updatedAt: topping.updatedAt,
        secondCategory: topping.menuId.toString(),
      )).toList());
      searchResults.addAll(variantList.where((variant) {
        return variant.nameVarian.toLowerCase().contains(enteredKeyword);
      }).map((variant) => model.Menu(
        id: variant.id,
        nameMenu: variant.nameVarian,
        price: '0',
        image: variant.image ?? '',
        stock: variant.stockVarian,
        category: variant.category,
        rating: 0.0,
        description: '',
        status: variant.status_variant,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        secondCategory: variant.category,
      )).toList());
    }
  }

  Future<void> fetchAllData() async {
    await Future.wait([
      getAllProductList(),
      getFoodList(),
      getDrinkList(),
      // getSnackList(),
      getToppingList(),
      getVariantList(),
    ]);
  }

  Future<void> getAllProductList() async {
    try {
      final response = await http.get(Uri.parse(FoodApi.getallProductList));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData is List) {
          allProductList.value = responseData.map((json) => model.Menu.fromJson(json)).toList();
          for (var product in allProductList) {
            if (product.stock == '0') {
              Get.snackbar(
                'Stok ${product.nameMenu} kosong',
                'Harap cek lagi stok produk anda!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            }
          }
          filterProducts();

        } else {
          print('Unexpected response format: ${responseData.runtimeType}');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> getAllProductList() async {
  //   try {
  //     final response = await http.get(Uri.parse(FoodApi.getallProductList));
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       if (responseData != null && responseData['menu'] is List) {
  //         final List<dynamic> allProductListData = responseData['menu'];
  //         allProductList.value = allProductListData
  //             .map((json) => model.Menu.fromJson(json))
  //             .toList();

  //         for (var product in allProductList) {
  //           if (product.stock == '0') {
  //             Get.snackbar(
  //               'Stok ${product.nameMenu} kosong',
  //               'Harap cek lagi stok produk anda!',
  //               snackPosition: SnackPosition.TOP,
  //               backgroundColor: Colors.redAccent,
  //               colorText: Colors.white,
  //             );
  //           }
  //         }

  //         filterProducts();
  //       } else {
  //         print('Data yang diterima tidak sesuai format yang diharapkan.');
  //       }
  //     } else {
  //       print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print("Error while fetching data: $error");
  //   } finally {
  //     isLoading.value = false;
  //     print('Selesai fetching data');
  //   }
  // }

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

  // Future<void> getSnackList() async {
    // try {
      // final response = await http.get(Uri.parse(FoodApi.getSnackList));
      // if (response.statusCode == 200) {
        // final responseData = json.decode(response.body);
        // if (responseData is Map<String, dynamic> &&
            // responseData['data'] is Map<String, dynamic> &&
            // responseData['data']['menu'] is List) {
          // final List<dynamic> snackListData = responseData['data']['menu'];
          // snackList.value =
              // snackListData.map((json) => model.Menu.fromJson(json)).toList();
          // filterProducts();
        // } else {
          // print('Data yang diterima tidak sesuai format yang diharapkan.');
        // }
      // } else {
        // print('Gagal mendapatkan data. Status respon: ${response.statusCode}');
      // }
    // } catch (error) {
      // print("Error while fetching data: $error");
    // } finally {
      // isLoading.value = false;
      // print('Selesai fetching data');
    // }
  // }

  Future<void> getToppingList() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(ToppingsApi.getallToppingsList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic>) {
          ToppingList toppingListData = ToppingList.fromJson(responseData);
          toppingList.value = toppingListData.data;
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

  Future<void> getVariantList() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(VariantApi.getallVariantList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic>) {
          VarianList variantListData = VarianList.fromJson(responseData);
          variantList.value = variantListData.data;
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
    print('Filtering for category: ${selectedCategory.value}');

    if (selectedCategory.value == 'Semua') {
      filteredProductList.assignAll(
        allProductList.where((product) => product.status != '0').toList()
      );

      filteredProductList.addAll(
        toppingList.where((topping) => topping.status_topping != '0').map((topping) => model.Menu(
          id: topping.id,
          nameMenu: topping.nameTopping,
          price: topping.price.toString(),
          image: '',
          stock: topping.stockTopping.toString(),
          category: 'Topping',
          rating: 0.0,
          description: topping.menus.map((menu) => menu.menuID).join(', '),
          status: topping.status_topping,
          createdAt: topping.createdAt,
          updatedAt: topping.updatedAt,
          secondCategory: topping.menuId.toString(),
        )).toList()
      );
      filteredProductList.addAll(
        variantList.where((variant) => variant.status_variant != '0').map((variant) => model.Menu(
          id: variant.id,
          nameMenu: variant.nameVarian,
          price: '0',
          image: variant.image ?? '',
          stock: variant.stockVarian,
          category: 'Variant',
          rating: 0.0,
          description: '',
          status: variant.status_variant,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          secondCategory: variant.category,
        )).toList()
      );
    } else if (selectedCategory.value == 'Makanan') {
      filteredProductList.assignAll(
        foodList.where((product) => product.status != '0').toList()
      );
    } else if (selectedCategory.value == 'Minuman') {
      filteredProductList.assignAll(
        drinklist.where((product) => product.status != '0').toList()
      );
    } else if (selectedCategory.value == 'Snack') {
      filteredProductList.assignAll(
        snackList.where((product) => product.status != '0').toList()
      );
    } else if (selectedCategory.value == 'Topping') {
      filteredProductList.assignAll(
        toppingList.where((topping) => topping.status_topping != '0').map((topping) => model.Menu(
          id: topping.id,
          nameMenu: topping.nameTopping,
          price: topping.price.toString(),
          image: '',
          stock: topping.stockTopping.toString(),
          category: 'Topping',
          rating: 0.0,
          description: topping.menus.map((menu) => menu.menuID).join(', '),
          status: topping.status_topping,
          createdAt: topping.createdAt,
          updatedAt: topping.updatedAt,
          secondCategory: topping.menuId.toString(),

        )).toList()
      );
    } else if (selectedCategory.value == 'Varian') {
      filteredProductList.assignAll(
        variantList.where((variant) => variant.status_variant != '0').map((variant) => model.Menu(
          id: variant.id,
          nameMenu: variant.nameVarian,
          price: '0',
          image: variant.image ?? '',
          stock: variant.stockVarian,
          category: 'Variant',
          rating: 0.0,
          description: '',
          status: variant.status_variant,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          secondCategory: variant.category,
        )).toList()
      );
    } else if (selectedCategory.value == 'Tidak Aktif') {
      filteredProductList.assignAll(
        allProductList.where((product) => product.status == '0').toList()
      );

      filteredProductList.addAll(
      toppingList.where((topping) => topping.status_topping == '0').map((topping) => model.Menu(
        id: topping.id,
        nameMenu: topping.nameTopping,
        price: topping.price.toString(),
        image: '',
        stock: topping.stockTopping.toString(),
        category: 'Topping',
        rating: 0.0,
        description: topping.menus.map((menu) => menu.menuID).join(', '),
        status: topping.status_topping,
        createdAt: topping.createdAt,
        updatedAt: topping.updatedAt,
        secondCategory: topping.menuId.toString(),
      )).toList()
    );

    filteredProductList.addAll(
      variantList.where((variant) => variant.status_variant == '0').map((variant) => model.Menu(
        id: variant.id,
        nameMenu: variant.nameVarian,
        price: '0',
        image: variant.image ?? '',
        stock: variant.stockVarian,
        category: 'Variant',
        rating: 0.0,
        description: '',
        status: variant.status_variant,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        secondCategory: variant.category,
      )).toList()
    );
    }

    print('Filtered products count: ${filteredProductList.length}');
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
        Get.snackbar('Sukses', 'Produk berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await fetchAllData();
      } else {
        print('Gagal menghapus produk. Status respon: ${response.statusCode}');
      }
    } catch (e) {
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
        Get.snackbar('Sukses', 'Topping berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await fetchAllData();
      } else {
        print('Gagal menghapus topping. Status respon: ${response.statusCode}');
      }
    } catch (e) {
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
        Get.snackbar('Sukses', 'Variant berhasil dihapus',
            snackPosition: SnackPosition.TOP);
        await fetchAllData();
      } else {
        print('Gagal menghapus variant. Status respon: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
