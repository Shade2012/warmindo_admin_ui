import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/data/api_controller.dart';
import 'package:warmindo_admin_ui/pages/model/product.dart';
import 'package:warmindo_admin_ui/pages/model/product_response.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:warmindo_admin_ui/pages/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class ProductList extends StatelessWidget {
  final List<Menu> productList;

  const ProductList({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final ApiController dataController = Get.put(ApiController());
    final ProductController productController = Get.put(ProductController());

    return Obx(
      () => Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                print('Original price: ${product.price}');

                double? priceAsDouble = double.tryParse(
                    product.price.replaceAll(',', '').replaceAll('.', ''));

                if (priceAsDouble == null) {
                  print('Error: price is not a valid double');
                  return Container();
                }

                double adjustedPrice = priceAsDouble / 100;

                print('Parsed price as double: $adjustedPrice');

                return ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PRODUCT_PAGE, arguments: product);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        topLeft: Radius.circular(2),
                      ),
                      child: SizedBox(
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.15,
                        child: FadeInImage(
                          placeholder: AssetImage(Images.mieAyam),
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
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
                      '${currencyFormat.format(adjustedPrice)} | ${product.stock} in stock',
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
                                  Navigator.of(context).pop();
                                },
                                onConfirmPressed: () {
                                  Get.toNamed(Routes.EDIT_PRODUCT_PAGE, arguments: product);
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
                                  productController.deleteProduct(product.menuId);
                                  dataController.fetchAllData();
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
            ),
          ),
        ],
      ),
    );
  }
}
