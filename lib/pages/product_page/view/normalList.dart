import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/pages/edit_product_page/controller/edit_product_controller.dart';
import 'package:warmindo_admin_ui/pages/edit_topping_page/controller/edit_topping_controller.dart';
import 'package:warmindo_admin_ui/pages/edit_varian_page/controller/edit_varian_controller.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:warmindo_admin_ui/global/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class ProductList extends StatelessWidget {
  final List<Menu> productList;
  final EditProductController editProductController = Get.put(EditProductController());
  final EditVariantController editVariantController = Get.put(EditVariantController());
  final EditToppingController editToppingController = Get.put(EditToppingController());

  ProductList({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final ProductController productController = Get.put(ProductController());

    return Obx(() {
      if (!productController.isConnected.value) {
        return Center(
          child: Text(
            'Tidak ada koneksi internet mohon cek internet anda',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
      }
      if (productController.isLoading.value) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Container(
                    width: screenWidth * 0.15,
                    height: screenHeight * 0.15,
                    color: Colors.white,
                  ),
                ),
                title: Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
                subtitle: Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, color: Colors.grey),
                    SizedBox(width: 8),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: false,
                        onChanged: (value) {},
                        activeColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemCount: 12,
        );
      } else if (productList.isEmpty) {
        return Center(
          child: Text(
            'Data produk kosong',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return RefreshIndicator(
          color: ColorResources.primaryColor,
          backgroundColor: ColorResources.primaryColorLight,
          onRefresh: () {
            return productController.fetchAllData();
          },
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              double? priceAsDouble = product.price != null
                  ? double.tryParse(
                      product.price.replaceAll(',', '').replaceAll('.', ''))
                  : null;

              return ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_PRODUCT_PAGE, arguments: product);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: SizedBox(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.15,
                      child: FadeInImage(
                        placeholder: AssetImage(Images.mieAyam),
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(Images.mieAyam);
                        },
                      ),
                    ),
                  ),
                ),
                title: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_PRODUCT_PAGE, arguments: product);
                  },
                  child: Text(
                    product.nameMenu,
                    style: titleproductTextStyle,
                  ),
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_PRODUCT_PAGE, arguments: product);
                  },
                  child: Text(
                    '${priceAsDouble != null ? currencyFormat.format(priceAsDouble) : 'Rp 0'} | ${product.stock} stok',
                    style: titleproductTextStyle,
                  ),
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
                                Get.back();
                              },
                              onConfirmPressed: () {
                                if (product.category == 'Topping') {
                                  Get.toNamed(Routes.EDIT_TOPPING_PAGE,
                                      arguments: product);
                                } else if (product.category == 'Variant') {
                                  Get.toNamed(Routes.EDIT_VARIAN_PAGE,
                                      arguments: product);
                                  print(product.category);
                                } else {
                                  Get.toNamed(Routes.EDIT_PRODUCT_PAGE,
                                      arguments: product);
                                }
                                productController.fetchAllData();
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
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: product.status == '1' ? true : false,
                        onChanged: (value) {
                          if (product.category == 'Topping') {
                            if (product.status == '1') {
                              editToppingController.disabledStatus(product.id.toString());
                              productController.fetchAllData();
                            } else {
                              editToppingController.enabledStatus(product.id.toString());
                              productController.fetchAllData();
                            }
                            product.status = value ? '1' : '0';
                          } else if (product.category == 'Variant') {
                            if (product.status == '1') {
                              editVariantController.disabledStatus(product.id.toString());
                              productController.fetchAllData();
                            } else {
                              editVariantController.enabledStatus(product.id.toString());
                              productController.fetchAllData();
                            }
                            product.status = value ? '1' : '0';
                          } else {
                            // Logika untuk kategori lainnya
                            if (product.status == '1') {
                              editProductController.disabledStatus(product.id.toString());
                              productController.fetchAllData();
                            } else {
                              editProductController.enabledStatus(product.id.toString());
                              productController.fetchAllData();
                            }
                            product.status = value ? '1' : '0';
                          }
                        },
                        activeColor: ColorResources.labelcomplete,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
