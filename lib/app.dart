import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sales_snap/utils/theme/app_theme.dart';

import 'views/bottom_navigation.dart';
import 'views/pages/account/login_signup_tabs.dart';

class App extends StatelessWidget {
  final GetStorage loginInfo = GetStorage();
  @override
  Widget build(BuildContext context) {
    String isLogin = loginInfo.read('isLogin');
    return GetMaterialApp(
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        home:
            isLogin?.contains('yes') ?? false ? BottomNavBar() : LoginSignUp());
  }
  // isLogin?.contains('yes') ?? false ? BottomNavBar() : LoginSignUp()
}
