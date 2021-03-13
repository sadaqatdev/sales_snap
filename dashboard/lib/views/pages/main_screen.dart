import 'package:flutter/material.dart';
import 'package:sales_snap_dashboard/views/pages/main_screen_page.dart';
import 'package:sales_snap_dashboard/views/pages/mobile_screen.dart';
import 'package:sales_snap_dashboard/views/widgets/responsive.dart';

import 'side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('-------------snaps=========');
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        // Let's work on our mobile part
        mobile: MobileScreen(),
        tablet: MobileScreen(),
        desktop: Row(
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            Expanded(
              flex: _size.width > 1340 ? 1 : 3,
              child: SideMenu(),
            ),

            Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: MainScreenPage(),
            ),
          ],
        ),
      ),
    );
  }
}
