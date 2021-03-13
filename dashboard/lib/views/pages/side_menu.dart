import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/navigation_controller.dart';
import 'package:sales_snap_dashboard/utils/constants.dart';
import 'package:sales_snap_dashboard/views/widgets/responsive.dart';
import 'package:sales_snap_dashboard/views/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GetBuilder<NavigationController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/Logo Outlook.png",
                      width: 46,
                    ),
                    Spacer(),
                    Text('Sales Snap'),
                    Spacer(
                      flex: 3,
                    ),
                    // We don't want to show this close button on Desktop mood
                    if (!Responsive.isDesktop(context)) CloseButton(),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                // SideMenuItem(
                //   press: () {
                //     controller.updateCurrent(1);
                //   },
                //   title: "Home",
                //   iconSrc: Icon(Icons.home),
                //   isActive: controller.currentIndex == 1 ? true : false,
                // ),
                SizedBox(
                  height: 18,
                ),
                SideMenuItem(
                  press: () {
                    controller.updateCurrent(2);
                  },
                  title: "Users",
                  iconSrc: Icon(Icons.person),
                  isActive: controller.currentIndex == 2 ? true : false,
                  itemCount: 3,
                ),
                SizedBox(
                  height: 18,
                ),
                SideMenuItem(
                  press: () {
                    controller.updateCurrent(3);
                  },
                  title: "Saved Items",
                  iconSrc: Icon(Icons.list),
                  isActive: controller.currentIndex == 3 ? true : false,
                ),
                SizedBox(
                  height: 18,
                ),
                SideMenuItem(
                  press: () {
                    controller.updateCurrent(4);
                  },
                  title: "Buyed Items",
                  iconSrc: Icon(Icons.list_alt),
                  isActive: controller.currentIndex == 4 ? true : false,
                ),
                SizedBox(
                  height: 18,
                ),
                SideMenuItem(
                  press: () {
                    controller.updateCurrent(5);
                  },
                  title: "Notifications",
                  iconSrc: Icon(Icons.notification_important),
                  isActive: controller.currentIndex == 5 ? true : false,
                  showBorder: false,
                ),
                SizedBox(height: kDefaultPadding * 2),
              ],
            );
          }),
        ),
      ),
    );
  }
}
