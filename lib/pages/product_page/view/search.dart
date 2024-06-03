import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import '../../../data/api_controller.dart';
import 'package:get/get.dart';
import '../../../routes/AppPages.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../widget/reusable_dialog.dart';

class Search extends StatelessWidget {
  final ApiController dataController = Get.put(ApiController());
  final ProductController productController = Get.put(ProductController());
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      if (dataController.isLoading.value) {
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
      } else {
        return ListView.builder(
          itemCount: dataController.searchResults.length,
          itemBuilder: (context, index) {
            final product = dataController.searchResults[index];
            double? priceAsDouble = double.tryParse(product.price.replaceAll(',', '').replaceAll('.', ''));
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
                              Get.back();
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
        );
      }
    });
  }
}
