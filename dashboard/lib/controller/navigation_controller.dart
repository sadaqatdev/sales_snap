import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';
import 'package:sales_snap_dashboard/views/pages/buyed_page.dart';
import 'package:sales_snap_dashboard/views/pages/home_page.dart';
import 'package:sales_snap_dashboard/views/pages/notification_page.dart';
import 'package:sales_snap_dashboard/views/pages/saved_page.dart';
import 'package:sales_snap_dashboard/views/pages/users.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find<NavigationController>();

  Widget currentPage = UsersPage();

  int currentIndex = 1;
  FirestoreMethods methods = FirestoreMethods();
  @override
  void onInit() {
    super.onInit();
  }

  void updateCurrent(index) {
    switch (index) {
      case 1:
        currentPage = HomePage();
        currentIndex = index;
        update();
        break;
      case 2:
        currentPage = UsersPage();
        currentIndex = index;
        update();
        break;
      case 3:
        currentPage = SavedPage();
        currentIndex = index;
        update();
        break;
      case 4:
        currentPage = BuyPage();
        currentIndex = index;
        update();
        break;
      case 5:
        currentPage = NotificationPage();
        currentIndex = index;
        update();
        break;
    }
  }
}
