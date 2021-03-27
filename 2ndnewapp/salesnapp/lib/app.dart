import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'views/bottom_navigation.dart';
import 'views/pages/account/login_signup_tabs.dart';
//  await Firebase.initializeApp();
//   await GetStorage().initStorage;

class App extends StatelessWidget {
  final storage = GetStorage();
   bool isLogin = false;
  Widget build(BuildContext context) {
    String login = storage.read('isLogin');
    login?.contains('yes') ?? false ? isLogin = true : isLogin = false;
    return GetMaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: isLogin ? BottomNavBar() : LoginSignUp(),
    );
  }
}
