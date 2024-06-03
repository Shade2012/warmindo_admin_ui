import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigatorController(), permanent: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  
  runApp(MyApp(startPage: token == null ? Routes.LOGIN_PAGE : Routes.BOTTOM_NAVIGATION));
}

class MyApp extends StatelessWidget {
  final String startPage;
  const MyApp({super.key, required this.startPage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Warmindo Admin UI',
      debugShowCheckedModeBanner: false,
      initialRoute: startPage,
      getPages: AppPages.routes,
    );
  }
}
