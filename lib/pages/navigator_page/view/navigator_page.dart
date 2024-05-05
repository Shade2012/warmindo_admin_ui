import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/view/cancel_order_page.dart';
import 'package:warmindo_admin_ui/pages/customers_page/view/customers_page.dart';
import 'package:warmindo_admin_ui/pages/home_page/view/home_page.dart';
import 'package:warmindo_admin_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/product_page.dart';
import 'package:warmindo_admin_ui/pages/setting_page/view/settings_page.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/icon_themes.dart';

class BottomNavbar extends StatelessWidget {
  final NavigatorController controller = Get.put(NavigatorController());

  final List<Widget> pages = [
    HomePage(),
    ProductPage(),
    CancelOrderPage(), // Empty Container for Cart Page (to replace with FloatingActionButton)
    CustomersPage(),
    const SettingsPage ()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeIndex(2);
        },
        child: Obx(() => (controller.currentIndex.value == 2 ? Icon(Icons.cancel, color: ColorResources.backgroundColor,): Icon(Icons.cancel_outlined, color: ColorResources.backgroundColor,))),
        backgroundColor: ColorResources.bgfloatingActionButtonColor,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeIndex,
        backgroundColor: ColorResources.backgroundColor,
        selectedItemColor: ColorResources.selectedItemColor,
        unselectedItemColor: ColorResources.unselectedItemColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Obx(() => SvgPicture.asset(controller.currentIndex.value == 1 ? IconThemes.iconmenuSelected : IconThemes.iconmenu)),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      )),
    );
  }
}
