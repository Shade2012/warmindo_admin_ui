import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/api_controller.dart';
import 'package:get/get.dart';

import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../widget/reusable_dialog.dart';
class Search extends StatelessWidget {
  final ApiController dataController = Get.put(ApiController());

   Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: dataController.searchResults.length,
      itemBuilder: (context, index) {
        final product = dataController.searchResults[index];
        double? priceAsDouble = double.tryParse(product.price.replaceAll(',', '').replaceAll('.', ''));
        double adjustedPrice = priceAsDouble! / 100;
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
  }
}