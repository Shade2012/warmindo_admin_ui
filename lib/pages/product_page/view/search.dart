import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/global/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/pages/edit_product_page/controller/edit_product_controller.dart';
import 'package:warmindo_admin_ui/pages/edit_topping_page/controller/edit_topping_controller.dart';
import 'package:warmindo_admin_ui/pages/edit_varian_page/controller/edit_varian_controller.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class Search extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final EditProductController editProductController = Get.put(EditProductController());
  final EditToppingController editToppingController = Get.put(EditToppingController());
  final EditVariantController editVariantController = Get.put(EditVariantController());
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
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
                    Icon(Icons.delete, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemCount: 12,
        );
      }
      if (productController.searchResults.length == 0) {
        return Center(
          child: Text('Produk tidak ditemukan'),
        );
      } else {
        return ListView.builder(
          itemCount: productController.searchResults.length,
          itemBuilder: (context, index) {
            final product = productController.searchResults[index];
            double? priceAsDouble = double.tryParse(
                product.price.replaceAll(',', '').replaceAll('.', ''));
            double adjustedPrice = priceAsDouble! / 100;

            return ListTile(
              leading: ClipRRect(
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
              title: Text(
                product.nameMenu,
                style: titleproductTextStyle,
              ),
              subtitle: Text(
                '${currencyFormat.format(adjustedPrice)} | ${product.stock} in stock',
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
                              Get.back();
                            },
                            onConfirmPressed: () {
                              Get.toNamed(Routes.EDIT_PRODUCT_PAGE,arguments: product);
                            },
                            cancelButtonColor: ColorResources.primaryColorLight,
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
        );
      }
    });
  }
}
