import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';

class CategoryWidget extends StatelessWidget {
  final Function(String) onCategorySelected;
  final String selectedCategory;

  CategoryWidget({
    Key? key,
    required this.onCategorySelected,
    required this.selectedCategory,
  }) : super(key: key);

  final List<String> categories = ['Semua', 'Makanan', 'Minuman', 'Snack', 'Topping', 'Varian', 'Tidak Aktif'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: List.generate(categories.length, (index) {
            final category = categories[index];
            final isSelected = category == selectedCategory;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                onTap: () {
                  onCategorySelected(category); 
                },
                child: Chip(
                  label: Text(category),
                  backgroundColor: isSelected
                      ? ColorResources.primaryColor
                      : ColorResources.primaryColorLight,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? ColorResources.primaryColorLight
                        : ColorResources.primaryColorDark,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
