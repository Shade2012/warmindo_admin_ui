import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/binding/add_product_binding.dart';
import 'package:warmindo_admin_ui/pages/add_product_page/view/add_product_page.dart';
import 'package:warmindo_admin_ui/pages/add_topping_page/binding/add_topping_binding.dart';
import 'package:warmindo_admin_ui/pages/add_topping_page/view/add_topping_page.dart';
import 'package:warmindo_admin_ui/pages/add_varian_page/view/add_varian_page.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/binding/bottomsheet_schedule_binding.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/view/bottomsheet_schedule_page.dart';
import 'package:warmindo_admin_ui/pages/change_pass_page/binding/changepass_binding.dart';
import 'package:warmindo_admin_ui/pages/change_pass_page/view/changepass_page.dart';
import 'package:warmindo_admin_ui/pages/customers_page/binding/customers_binding.dart';
import 'package:warmindo_admin_ui/pages/customers_page/view/customers_page.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/binding/detail_order_binding.dart';
import 'package:warmindo_admin_ui/pages/detail_order_page/view/detail_order_page.dart';
import 'package:warmindo_admin_ui/pages/detail_product_page/binding/detailproduct_binding.dart';
import 'package:warmindo_admin_ui/pages/detail_product_page/view/detailproduct_page.dart';
import 'package:warmindo_admin_ui/pages/edit_customers_page/binding/edit_customers_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_customers_page/view/edit_customers_page.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/binding/edit_order_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_order_page/view/edit_order_page.dart';
import 'package:warmindo_admin_ui/pages/edit_product_page/binding/edit_product_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_product_page/view/edit_product_page.dart';
import 'package:warmindo_admin_ui/pages/edit_profile_page/binding/edit_profile_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_profile_page/view/edit_profile_page.dart';
import 'package:warmindo_admin_ui/pages/edit_topping_page/binding/edit_topping_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_topping_page/view/edit_topping_page.dart';
import 'package:warmindo_admin_ui/pages/edit_varian_page/binding/edit_varian_binding.dart';
import 'package:warmindo_admin_ui/pages/edit_varian_page/view/edit_varian_page.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/binding/general_info_binding.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/view/general_info_page.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/binding/history_binding.dart';
import 'package:warmindo_admin_ui/pages/history_order_page/view/history_page.dart';
import 'package:warmindo_admin_ui/pages/home_page/binding/home_binding.dart';
import 'package:warmindo_admin_ui/pages/home_page/view/home_page.dart';
import 'package:warmindo_admin_ui/pages/input_notification_page/binding/input_notification_binding.dart';
import 'package:warmindo_admin_ui/pages/input_notification_page/view/input_notification_page.dart';
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
import 'package:warmindo_admin_ui/pages/schedule_page/binding/schedule_binding.dart';
import 'package:warmindo_admin_ui/pages/schedule_page/view/schedule_page.dart';
import 'package:warmindo_admin_ui/pages/splash_page/binding/splash_binding.dart';
import 'package:warmindo_admin_ui/pages/splash_page/view/splash_page.dart';
import '../pages/detail_customers_page/binding/detail_customers_binding.dart';
import '../pages/detail_customers_page/view/detail_customers_page.dart';
part 'AppRoutes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_PAGE;
  static final routes = [
    GetPage(
        name: _Paths.BOTTOM_NAVIGATION,
        page: () => BottomNavbar(),
        bindings: [
          HomePageBinding(),
          ProductBinding(),
          OrderBinding(),
          CustomersBinding(),
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
        name: _Paths.SCHEDULE_PAGE,
        page: () => SchedulePage(),
        binding: ScheduleBinding(),
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
        page: () => DetailProductPage(product: Get.arguments),
        binding: DetailProductBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAIL_ORDER_PAGE,
        page: () => DetailOrderPage(order: Get.arguments),
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
    GetPage(
        name: _Paths.EDIT_PRODUCT_PAGE,
        page: () => EditProductPage(product: Get.arguments),
        binding: EditProductBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.EDIT_CUSTOMERS_PAGE,
        page: () => EditCustomersPage(customers: Get.arguments),
        binding: EditCustomersBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.CUSTOMERS_PAGE,
        page: () => CustomersPage(),
        binding: CustomersBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.BOTTOM_SHEET_SCHEDULE,
        page: () => BottomSheetSchedule(),
        binding: BottomSheetScheduleBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.ADD_VARIAN_PAGE,
        page: () => AddVarianPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.EDIT_VARIAN_PAGE,
        page: () => EditVarianPage(varian: Get.arguments),
        binding: EditVariantBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.EDIT_ORDER_PAGE,
        page: () => EditOrderPage(order: Get.arguments), 
        binding: EditOrderBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.ADD_TOPPING_PAGE,
        page: () => AddToppingPage(),
        binding: AddToppingBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.EDIT_TOPPING_PAGE,
        page: () => EditToppingPage(topping: Get.arguments),
        binding: EditToppingBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.DETAIL_CUSTOMERS_PAGE,
        page: () => DetailCustomersPage(customerData: Get.arguments),
        binding: DetailCustomersBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 100)),
    GetPage(
        name: _Paths.ORDER_HISTORY_PAGE,
        page: () => HistoryPage(),
        binding: HistoryBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 100)),
    GetPage(
        name: _Paths.DETAIL_HISTORY_PAGE,
        page: () => DetailOrderPage(order: Get.arguments),
        binding: DetailOrderBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 100)),
    GetPage(
        name: _Paths.INPUT_NOTIFICATION_PAGE,
        page: () => InputNotificationPage(),
        binding: InputNotificationBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 100))
  ];
}
