import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_snap/controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavController _navController = Get.put(BottomNavController());
  //  selectedLabelStyle: GoogleFonts.montserrat()
  //       .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
  //             unselectedLabelStyle:GoogleFonts.montserrat()
  //       .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
  //             currentIndex: _navController.currentIndex,
  //             onTap: (index) {
  //               _navController.updateCurrentPage(index);
  //             },
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GetBuilder<BottomNavController>(builder: (controller) {
      var color2 = Color(0xff8280A1);
       
      return Scaffold(
        body: _navController.currentPage,
        backgroundColor: Color(0xffE5E5E5),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: 35, left: 12, right: 12),
            padding: EdgeInsets.only(top: 12),
            height: 80,
            color: Color(0xffE5E5E5),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BarItem(
                    color2:
                        controller.currentIndex == 0 ? primaryColor : color2,
                    data: 'Home',
                    icon: Icons.home,
                    onPress: () {
                      controller.updateCurrentPage(0);
                    },
                  ),
                  BarItem(
                    color2:
                        controller.currentIndex == 1 ? primaryColor : color2,
                    data: 'My Items',
                    icon: Icons.list,
                    onPress: () {
                      controller.updateCurrentPage(1);
                    },
                  ),
                  BarItem(
                    color2:
                        controller.currentIndex == 2 ? primaryColor : color2,
                    data: "Notifications",
                    icon: Icons.notifications,
                    onPress: () {
                      controller.updateCurrentPage(2);
                    },
                  ),
                  BarItem(
                    color2:
                        controller.currentIndex == 3 ? primaryColor : color2,
                    data: 'Account',
                    icon: Icons.person,
                    onPress: () {
                      controller.updateCurrentPage(3);
                    },
                  )
                ],
              ),
            )),
      );
    });
  }
}

class BarItem extends StatelessWidget {
  const BarItem({
    Key key,
    @required this.color2,
    @required this.data,
    @required this.onPress,
    @required this.icon,
  }) : super(key: key);

  final Color color2;
  final String data;
  final Function onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color2,
          ),
          Text(
            data,
            style: GoogleFonts.montserrat()
      .copyWith(fontSize: 14, fontWeight: FontWeight.w500,color: color2),
          ),
        ],
      ),
    );
  }
}
// Card(
//             elevation: 3,
//             margin: EdgeInsets.only(left: 12, right: 12, bottom: 30),
//             semanticContainer: true,
             
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: BottomNavigationBar(
           
//               type: BottomNavigationBarType.fixed,
              
//               items: [
//                 BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.list), label: 'My Items'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.notifications),
//                     label: 'Notifications'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.person_outlined), label: 'Account')
//               ],
//             ),