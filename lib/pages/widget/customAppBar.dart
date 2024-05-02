import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/widget/searchbar.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Function()? onBackButtonPressed; // Tambahkan ini

  const CustomAppBar({
    Key? key,
    this.title = '',
    this.showBackButton = false,
    this.onBackButtonPressed, // Tambahkan ini
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
                  if (showBackButton) // Tambahkan kondisi untuk menampilkan tombol back
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: onBackButtonPressed,
                    ),
                  Text(
                    title.isNotEmpty ? title : 'Halo, Admin!',
                    style: homeWelcomeTextStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomSearchBar(
              hintText: 'Search',
              controller: SearchController(),
            ),
          ),
          SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
