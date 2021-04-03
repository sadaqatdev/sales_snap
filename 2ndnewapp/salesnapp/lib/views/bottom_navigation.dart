import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_snap/controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavController _navController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
  
    return GetBuilder<BottomNavController>(builder: (controller) {
      return Scaffold(
        body: _navController.currentPage,
        backgroundColor: Color(0xffE5E5E5),
        bottomNavigationBar: Container(
          color: Color(0xffE5E5E5),
          child: Card(
            elevation: 3,
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 30),
            semanticContainer: true,
             
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: BottomNavigationBar(
              selectedLabelStyle: GoogleFonts.montserrat()
        .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              unselectedLabelStyle:GoogleFonts.montserrat()
        .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              currentIndex: _navController.currentIndex,
              onTap: (index) {
                _navController.updateCurrentPage(index);
              },
              type: BottomNavigationBarType.fixed,
              
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'My Items'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifications'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outlined), label: 'Account')
              ],
            ),
          ),
        ),
      );
    });
  }
 
}
