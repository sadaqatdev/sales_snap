import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavController _navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final bottomNavTheme = Theme.of(context).bottomNavigationBarTheme;
    return GetBuilder<BottomNavController>(builder: (controller) {
      return SafeArea (
        child: Scaffold(
          body: _navController.currentPage,
          backgroundColor: Color(0xffE5E5E5),
          bottomNavigationBar: Container(
            color: Color(0xffE5E5E5),
            child: Card(
              elevation: 3,
              margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
              semanticContainer: true,
              color: Color(0xffE5E5E5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: BottomNavigationBar(
                selectedLabelStyle: bottomNavTheme.selectedLabelStyle,
                unselectedLabelStyle: bottomNavTheme.unselectedLabelStyle,
                currentIndex: _navController.currentIndex,
                onTap: (index) {
                  _navController.updateCurrentPage(index);
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'My Items'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notification_important),
                      label: 'Notifications'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outlined), label: 'Account')
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
 
}
