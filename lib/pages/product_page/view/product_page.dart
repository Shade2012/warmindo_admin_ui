import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/normalList.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/search.dart';
import 'package:warmindo_admin_ui/pages/product_page/widget/categoryWidget.dart';
import 'package:warmindo_admin_ui/pages/product_page/widget/popup_add_product.dart';
import 'package:warmindo_admin_ui/global/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/global/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kelola Produk',onChanged: (query){
        print(query);{
          productController.searchFilter(query);
          print(productController.searchResults);
        }
      }, controller: productController.search,
      ),
      body: Column(
        children: [
          CategoryWidget(
            onCategorySelected: (selectedCategory) {
              productController.selectedCategory(selectedCategory);
              if (selectedCategory == 'Semua') {
                productController.getAllProductList();
              } else if (selectedCategory == 'Makanan') {
                productController.getFoodList();
              } else if (selectedCategory == 'Minuman') {
                productController.getDrinkList();
              } else if (selectedCategory == 'Snack') {
                productController.getSnackList();
              } else if (selectedCategory == 'Topping') {
                productController.getToppingList();
              } else if (selectedCategory == 'Varian') {
                productController.getVariantList();
              }
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
                if(productController.searchObx.isNotEmpty){
                  return Search();
                }
                else{
                  return ProductList(productList: productController.filteredProductList);
                }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReusableDialog(
                title: "Add Product",
                content: "Apakah Kamu yakin ingin menambah data?",
                cancelText: "Tidak",
                confirmText: "Iya",
                onCancelPressed: () {
                  Navigator.of(context).pop();
                },
                onConfirmPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupAddProducts();
                      }
                  );
                },
                cancelButtonColor: ColorResources.primaryColorLight,
                confirmButtonColor: ColorResources.buttonadd,
                dialogImage: Image.asset(Images.askDialog),
              );
            },
          );
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
