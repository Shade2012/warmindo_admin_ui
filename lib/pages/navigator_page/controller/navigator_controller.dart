import 'package:get/get.dart';

class NavigatorController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void goToHomePage() {
    currentIndex.value = 0; //index untuk homepage
  }

  void goToCartPage() {
    currentIndex.value = 2; // index untuk cartpage
  }

  void goToCustomersPage() {
    currentIndex.value = 3; // index untuk customerspage
  }

   void goToSettingsPage() {
    currentIndex.value = 4; // Index untuk SettingsPage
  }

}