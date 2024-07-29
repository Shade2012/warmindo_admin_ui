import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/global/model/product_response.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/global/widget/reusable_dialog.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class DetailProductPage extends StatelessWidget {
  final Menu product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final ProductController productController = Get.find<ProductController>();

    // Handle potential null or invalid price
    double? priceAsDouble = double.tryParse(product.price?.replaceAll(',', '').replaceAll('.', '') ?? '');

    // Handle potential null or invalid ratings
    double? ratingAsDouble = double.tryParse(product.ratings ?? '');
    String ratingString = ratingAsDouble?.toString() ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        title: Text('Detail Produk'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.25,
                child: Image.network(
                  product.image ?? '', // Handle null image URL
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, color: Colors.red);
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nameMenu ?? 'No Name', // Handle null name
                  style: nameProductDetailTextStyle,
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  product.category ?? 'No Category', // Handle null category
                  style: categoryProductDetailTextStyle,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  ratingString,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi',
                  style: descProductDetailTextStyle,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  product.description ?? 'No Description', // Handle null description
                  style: desccontentProductDetailTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.1,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Harga',
                    style: priceHProductDetailTextStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    priceAsDouble != null
                        ? '${currencyFormat.format(priceAsDouble)}'
                        : 'Tidak ada harga',
                    style: priceCProductDetailTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.pencil),
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
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Container(
                    width: screenWidth * 0.1,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.solidTrashCan),
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
                                productController.deleteProduct(product.id);
                                productController.fetchAllData();
                                Get.back();
                              },
                              cancelButtonColor: ColorResources.primaryColorLight,
                              confirmButtonColor: ColorResources.buttondelete,
                              dialogImage: Image.asset(Images.askDialog),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
