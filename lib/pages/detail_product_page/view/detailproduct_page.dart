import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/model/product_response.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class DetailProductPage extends StatelessWidget {
  final Menu product;
  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                width: screenWidth * 0.8, // Menggunakan 80% lebar layar
                height: screenHeight * 0.25, // Menggunakan 30% tinggi layar
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nameMenu,
                  style: nameProductDetailTextStyle,
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  product.category,
                  style: categoryProductDetailTextStyle,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: screenWidth * 0.02), // Jarak 2% lebar layar
                Text(
                  product.ratings,
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
                  product.description,
                  style: desccontentProductDetailTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.1, // Menggunakan 10% tinggi layar
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
                    product.price,
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
