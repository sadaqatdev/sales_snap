import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/views/pages/account/account_page.dart';
import 'package:sales_snap/views/pages/home_page.dart';
import 'package:sales_snap/views/pages/my_items.dart';
import 'package:sales_snap/views/pages/notifications_page.dart';

class BottomNavController extends GetxController {
  Widget currentPage = HomePage();
  int currentIndex = 0;
  double padding;
  @override
    void onInit() {
    if(Platform.isAndroid){
      padding=8;
    }else{
      padding=35;
    }
      super.onInit();
    }
  void updateCurrentPage(int index) {
    switch (index) {
      case 0:
        currentPage = HomePage();
        currentIndex = index;
        update();
        break;
      case 1:
        currentPage = MyItemPage();
        currentIndex = index;
        update();
        break;
      case 2:
        currentPage = NotificationPage();
        currentIndex = index;
        update();
        break;
      case 3:
        currentPage = AccountPage();
        currentIndex = index;
        update();
        break;
    }
  }
}
