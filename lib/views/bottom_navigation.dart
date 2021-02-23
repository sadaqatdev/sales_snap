import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavController _navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final bottomNavTheme = Theme.of(context).bottomNavigationBarTheme;
    return GetBuilder<BottomNavController>(builder: (controller) {
      return Scaffold(
        body: _navController.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: bottomNavTheme.selectedLabelStyle,
          unselectedLabelStyle: bottomNavTheme.unselectedLabelStyle,
          currentIndex: _navController.currentIndex,
          onTap: (index) {
            _navController.updateCurrentPage(index);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'My Items'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_important),
                label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'Account')
          ],
        ),
      );
    });
  }
}
