import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/widget/searchbar.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    this.title = '',
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
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title.isNotEmpty ? title : 'Halo, Admin!',
                style: homeWelcomeTextStyle,
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
