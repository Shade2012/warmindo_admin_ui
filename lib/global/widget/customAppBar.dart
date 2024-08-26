import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool showSearch;

  CustomAppBar({
    Key? key,
    this.title = '',
    this.controller,
    this.onChanged,
    this.showSearch = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(95);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorResources.primaryColor,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title.isNotEmpty ? title : 'Halo, Admin!',
                    style: homeWelcomeTextStyle,
                  ),
                ],
              ),
            ),
          ),
          if (showSearch) // Menampilkan pencarian jika showSearch true
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: hintSearchBarTextStyle.copyWith(color: greyTextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  prefixIcon: Icon(Icons.search),
                ),
                style: searchBarTextStyle,
              ),
            ),
          SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
