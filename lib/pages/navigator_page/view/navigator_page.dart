import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/cancel_order_page/view/cancel_order_page.dart';
import 'package:warmindo_admin_ui/pages/customers_page/view/customers_page.dart';
import 'package:warmindo_admin_ui/pages/home_page/view/home_page.dart';
import 'package:warmindo_admin_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/product_page.dart';
import 'package:warmindo_admin_ui/pages/setting_page/view/settings_page.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/icon_themes.dart';

class BottomNavbar extends StatelessWidget {
  final NavigatorController controller = Get.put(NavigatorController());

  final List<Widget> pages = [
    HomePage(),
    ProductPage(),
    CancelOrderPage(),
    CustomersPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => pages[controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.changeIndex(2);
        },
        child: Obx(() => Container(
            width: 30,
            child: SvgPicture.asset(controller.currentIndex.value == 2
                ? IconThemes.iconcancelSelected
                : IconThemes.iconcancel))),
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
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Obx(() => SvgPicture.asset(
                    controller.currentIndex.value == 1
                        ? IconThemes.iconmenuSelected
                        : IconThemes.iconmenu)),
                label: 'Produk',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Pelanggan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Pengaturan',
              ),
            ],
            selectedLabelStyle: BottomNavbarSelectedTextStyle,
            unselectedLabelStyle: BottomNavbarUnselectedTextStyle,
          )),
    );
  }
}
