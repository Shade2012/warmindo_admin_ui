import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/model/product.dart';
import 'package:warmindo_admin_ui/pages/widget/categoryWidget.dart';
import 'package:warmindo_admin_ui/pages/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/pages/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> filteredProducts =
      productList; // Inisialisasi dengan semua produk

  void filterProducts(String category) {
    if (category == 'Semua') {
      setState(() {
        filteredProducts = productList; // Tampilkan semua produk
      });
    } else {
      setState(() {
        filteredProducts = productList
            .where((product) => product.category == category)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Product',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.01, vertical: screenHeight * 0.01),
        child: Column(
          children: [
            CategoryWidget(
              onCategorySelected: (selectedCategory) {
                filterProducts(selectedCategory);
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        topLeft: Radius.circular(2),
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.15,
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: titleproductTextStyle,
                    ),
                    subtitle: Text(
                      'Rp ${product.price.toStringAsFixed(0)} | ${product.stock} in stock',
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
                                  title: "Edit Product",
                                  content:
                                      "Apakah Kamu yakin ingin mengubah data?",
                                  cancelText: "Tidak",
                                  confirmText: "Iya",
                                  onCancelPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onConfirmPressed: () {
                                    Get.toNamed(Routes.EDIT_PRODUCT_PAGE);
                                  },
                                  cancelButtonColor:
                                      ColorResources.primaryColorLight,
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
                                  content:
                                      "Apakah Kamu yakin ingin menghapus data?",
                                  cancelText: "Tidak",
                                  confirmText: "Iya",
                                  onCancelPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onConfirmPressed: () {
                                    Navigator.of(context).pop();
                                    // Get.toNamed(Routes.LOGIN_PAGE);
                                  },
                                  cancelButtonColor:
                                      ColorResources.primaryColorLight,
                                  confirmButtonColor:
                                      ColorResources.buttondelete,
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
              ),
            ),
          ],
        ),
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
                  Get.toNamed(Routes.ADD_PRODUCT_PAGE);
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
        ), // Icon plus
      ),
    );
  }
}
