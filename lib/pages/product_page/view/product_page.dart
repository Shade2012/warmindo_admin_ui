import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/data/api_controller.dart';
import 'package:warmindo_admin_ui/pages/model/product_response.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/normalList.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/search.dart';
import 'package:warmindo_admin_ui/pages/product_page/widget/categoryWidget.dart';
import 'package:warmindo_admin_ui/pages/product_page/widget/popup_add_product.dart';
import 'package:warmindo_admin_ui/pages/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/pages/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/pages/widget/skeleton.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class ProductPage extends StatelessWidget {

  ProductPage({Key? key}) : super(key: key);

  final ApiController dataController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Product',onChanged: (query){
        print(query);{
          dataController.searchFilter(query);
          print(dataController.searchResults);
        }
      }, controller: dataController.search,
      ),
      body: Column(
        children: [
          CategoryWidget(
            onCategorySelected: (selectedCategory) {
              dataController.setCategory(selectedCategory);
              if (selectedCategory == 'Semua') {
                dataController.getAllProductList();
              } else if (selectedCategory == 'Makanan') {
                dataController.getFoodList();
              } else if (selectedCategory == 'Minuman') {
                dataController.getDrinkList();
              } else if (selectedCategory == 'Snack') {
                dataController.getSnackList();
              } else if (selectedCategory == 'Topping') {
                dataController.getToppingList();
              } else if (selectedCategory == 'Varian') {
                dataController.getVariantList();
              }
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if(dataController.isLoading.value == true){
                return ListView.separated(
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Skeleton(
                          width: double.infinity,
                          height: 60,
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(height: 20,);
                    },
                    itemCount: 12);
              } else{
                if(dataController.searchResults.isNotEmpty){
                  return Search();
                }
                else{
                  return ProductList(productList: dataController.filteredProductList);
                }
              }


            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn1',
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
