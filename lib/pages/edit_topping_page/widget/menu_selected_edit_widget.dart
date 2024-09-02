import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/global/model/model_menu_or_topping.dart';
import 'package:warmindo_admin_ui/global/model/model_product_response.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/product_page/controller/product_controller.dart';

class MenuSelectedEdit extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  // final Topping topping;
  final MenuOrTopping menuOrTopping;

  MenuSelectedEdit({required this.menuOrTopping});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Obx(() {
      if (productController.foodList.isNotEmpty) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
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
              children: [
                _buildMenuList(),
              ],
            ),
          ),
        );
      } else {
        return Center(child: Text('Kosong'));
      }
    });
  }

  Widget _buildMenuList() {
    final menuList = productController.foodList.value.reversed;
    final groupedMenu = <String, List<Menu>>{};

    for (var menu in menuList) {
      if (groupedMenu.containsKey(menu.secondCategory)) {
        groupedMenu[menu.secondCategory]!.add(menu);
      } else {
        groupedMenu[menu.secondCategory] = [menu];
      }
    }

    for (var menu in menuList) {
      final matchingToppings = productController.toppingList.where((topping) =>
          topping.menus.any((menuTopping) => menuTopping.menuID == menu.id));

      if (matchingToppings.isNotEmpty) {
        menu.isSelected.value = true;
      }
    }

    return ListView.builder(
      itemCount: groupedMenu.keys.length,
      itemBuilder: (context, categoryIndex) {
        final category = groupedMenu.keys.elementAt(categoryIndex);
        final menus = groupedMenu[category]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: boldTextStyle),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: menus.length,
              itemBuilder: (context, menuIndex) {
                final menu = menus[menuIndex];
                return ListTile(
                  title: Text(menu.nameMenu),
                  trailing: Checkbox(
                    value: menu.isSelected.value,
                    onChanged: (value) {
                      menu.isSelected.value = value ?? false;
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
