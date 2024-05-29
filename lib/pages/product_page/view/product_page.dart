import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/data/api_controller.dart';
import 'package:warmindo_admin_ui/pages/model/product_response.dart';
import 'package:warmindo_admin_ui/pages/product_page/widget/categoryWidget.dart';
import 'package:warmindo_admin_ui/pages/product_page/widget/popup_add_product.dart';
import 'package:warmindo_admin_ui/pages/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/pages/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ApiController dataController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Product',
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
                dataController.getSnackList();
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
              List<Menu> productList = dataController.filteredProductList;

              // Urutkan daftar produk berdasarkan menuID secara ascending
              productList.sort((a, b) => a.menuId.compareTo(b.menuId));

              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        topLeft: Radius.circular(2),
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.15,
                        child: FadeInImage(
                          placeholder: AssetImage(Images.mieAyam),
                          image: NetworkImage('https://picsum.photos/250?image=9'),
                          fit: BoxFit.cover,
                        ),
                        
                      ),
                    ),
                    title: Text(
                      product.nameMenu,
                      style: titleproductTextStyle,
                    ),
                    subtitle: Text(
                      'Rp ${product.price} | ${product.stock} in stock',
                      style: titleproductTextStyle,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ReusableDialog(
                                  title: "Edit",
                                  content: "Apakah Kamu yakin ingin mengubah data?",
                                  cancelText: "Tidak",
                                  confirmText: "Iya",
                                  onCancelPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onConfirmPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  cancelButtonColor: ColorResources.primaryColorLight,
                                  confirmButtonColor: ColorResources.buttonedit,
                                  dialogImage: Image.asset(Images.askDialog),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ReusableDialog(
                                  title: "Delete",
                                  content: "Apakah Kamu yakin ingin menghapus data?",
                                  cancelText: "Tidak",
                                  confirmText: "Iya",
                                  onCancelPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onConfirmPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  cancelButtonColor: ColorResources.primaryColorLight,
                                  confirmButtonColor: ColorResources.buttondelete,
                                  dialogImage: Image.asset(Images.askDialog),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
