import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';

class CategoryWidget extends StatefulWidget {
  final Function(String) onCategorySelected; // Callback untuk kategori terpilih
  const CategoryWidget({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late List<bool> isSelected;
  final List<String> categories = ['Semua', 'Makanan', 'Minuman', 'Snack', 'Topping', 'Varian'];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(categories.length, (_) => false);
    isSelected[0] = true; // Default category selection
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: List.generate(categories.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // Reset all selections and select the tapped category
                    isSelected = List.generate(categories.length, (_) => false);
                    isSelected[index] = true;
                    widget.onCategorySelected(categories[index]); // Panggil callback
                  });
                },
                child: Chip(
                  label: Text(categories[index]),
                  backgroundColor: isSelected[index]
                      ? ColorResources.primaryColor
                      : ColorResources.primaryColorLight,
                  labelStyle: TextStyle(
                    color: isSelected[index]
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
