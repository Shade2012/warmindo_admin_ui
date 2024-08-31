import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart' as model;
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';

class MenuSelected extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  // final CartController cartController = Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    final foodList = productController.foodList;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx((){
      if(foodList.isNotEmpty){
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 10, top: 25, left: 20, right: 20),
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.9,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                final menuList = productController.foodList.value.reversed;
                final groupedMenu = <String, List<model.Menu>>{};
                for (var menu in menuList) {
                  if (groupedMenu.containsKey(menu.secondCategory)) {
                    groupedMenu[menu.secondCategory]!.add(menu);
                  } else {
                    groupedMenu[menu.secondCategory] = [menu];
                  }
                }

                return Column(
                  children: [
                    Text('Pilih Topping ingin berada di menu apa',style: boldTextStyle,),
                    SizedBox(height: 10,),
                    Container(
                      constraints: BoxConstraints(maxHeight: screenHeight * 0.7),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final category = groupedMenu.keys.toList()[index];
                          final items = groupedMenu[category]!;

                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category),
                                SizedBox(height: 10),
                                Wrap(
                                  spacing: 10.0,
                                  runSpacing: 5.0,
                                  children: items.map((item) {
                                    return Obx((){
                                      return InkWell(
                                        onTap: () {
                                          item.isSelected.value = !item.isSelected.value; // Toggle selection
                                          productController.updateSelection();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: item.isSelected.value ? Colors.black : Colors.grey,
                                              width: item.isSelected.value ? 2 : 1
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                            color: item.isSelected.value? ColorResources.primaryColor : Colors.white
                                          ),
                                          child: Text('${item.id} | ${item.nameMenu}',style: popupText(item.isSelected.value),),
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: groupedMenu.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Divider(color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),


            ],
          ),
        ),
      );
      }else{
        return Center(child: Text('ksoong'),);
      }
    });
  }
}
