import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/binding/add_product_binding.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/view/add_product_page.dart';
import 'package:warmindo_admin_ui/pages/change_pass_page/binding/changepass_binding.dart';
import 'package:warmindo_admin_ui/pages/change_pass_page/view/changepass_page.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/binding/detail_order_binding.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/view/detail_order_page.dart';
import 'package:warmindo_admin_ui/pages/detail_product_page/binding/detailproduct_binding.dart';
import 'package:warmindo_admin_ui/pages/detail_product_page/view/detailproduct_page.dart';
import 'package:warmindo_admin_ui/pages/edit_profile_page/binding/edit_profile_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_profile_page/view/edit_profile_page.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/binding/general_info_binding.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/view/general_info_page.dart';
import 'package:warmindo_admin_ui/pages/home_page/binding/home_binding.dart';
import 'package:warmindo_admin_ui/pages/home_page/view/home_page.dart';
import 'package:warmindo_admin_ui/pages/login_page/binding/login_binding.dart';
import 'package:warmindo_admin_ui/pages/login_page/view/login_page.dart';
import 'package:warmindo_admin_ui/pages/navigator_page/view/navigator_page.dart';
import 'package:warmindo_admin_ui/pages/order_page/binding/order_binding.dart';
import 'package:warmindo_admin_ui/pages/order_page/view/order_page.dart';
import 'package:warmindo_admin_ui/pages/product_page/binding/product_binding.dart';
import 'package:warmindo_admin_ui/pages/product_page/view/product_page.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/binding/sales_detail_binding.dart';
import 'package:warmindo_admin_ui/pages/sales_detail_page/view/sales_detail_page.dart';
import 'package:warmindo_admin_ui/pages/setting_page/binding/settings_binding.dart';
import 'package:warmindo_admin_ui/pages/setting_page/view/settings_page.dart';
import 'package:warmindo_admin_ui/pages/shop_page/binding/shop_binding.dart';
import 'package:warmindo_admin_ui/pages/shop_page/view/shop_page.dart';
import 'package:warmindo_admin_ui/pages/splash_page/binding/splash_binding.dart';
import 'package:warmindo_admin_ui/pages/splash_page/view/splash_page.dart';
import 'package:warmindo_admin_ui/pages/verify_page/binding/verify_binding.dart';
import 'package:warmindo_admin_ui/pages/verify_page/view/verify_page.dart';
import 'package:warmindo_admin_ui/pages/voucher_page/binding/voucher_binding.dart';
import 'package:warmindo_admin_ui/pages/voucher_page/view/voucher_page.dart';
part 'AppRoutes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DETAIL_ORDER_PAGE;

  static final routes = [
    GetPage(
        name: _Paths.BOTTOM_NAVIGATION,
        page: () => BottomNavbar(),
        bindings: [
          HomePageBinding(),
          ProductBinding(),
          OrderBinding(),
          ShopBinding(),
          SettingsBinding()
        ],
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.HOME_PAGE,
        page: () => HomePage(),
        binding: HomePageBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.LOGIN_PAGE,
        page: () => LoginPage(),
        binding: LoginBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1500)),
    GetPage(
        name: _Paths.SHOP_PAGE,
        page: () => ShopPage(),
        binding: ShopBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.PRODUCT_PAGE,
        page: () => ProductPage(),
        binding: ProductBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.SETTINGS_PAGE,
        page: () => SettingsPage(),
        binding: SettingsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.ADD_PRODUCT_PAGE,
        page: () => AddProductPage(),
        binding: AddProductBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAIL_PRODUCT_PAGE,
        page: () => DetailProductPage(),
        binding: DetailProductBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAIL_ORDER_PAGE,
        page: () => DetailOrderPage(),
        binding: DetailOrderBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.ORDER_PAGE,
        page: () => OrderPage(),
        binding: OrderBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.VERIFY_PAGE,
        page: () => VerifyPage(),
        binding: VerifyBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.VOUCHER_PAGE,
        page: () => VoucherPage(),
        binding: VoucherBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.EDIT_PROFILE_PAGE,
        page: () => EditProfilPage(),
        binding: EditProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.SPLASH_PAGE,
        page: () => SplashPage(),
        binding: SplashBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.CHANGEPASS_PAGE,
        page: () => ChangePassPage(),
        binding: ChangePassBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.GENERAL_INFORMATION_PAGE,
        page: () => GeneralInformation(),
        binding: GeneralInformationBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAIL_SALES_PAGE,
        page: () => SalesDetailPage(),
        binding: SalesBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
  ];
}
