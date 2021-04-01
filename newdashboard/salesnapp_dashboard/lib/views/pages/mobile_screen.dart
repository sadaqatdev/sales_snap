import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sales_snap_dashboard/utils/constants.dart';
import 'package:sales_snap_dashboard/views/pages/main_screen_page.dart';
import 'package:sales_snap_dashboard/views/pages/side_menu.dart';
import 'package:sales_snap_dashboard/views/widgets/responsive.dart';

class MobileScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: SideMenu(),
      ),
      body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgDarkColor,
          child: SafeArea(
              right: false,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        // Once user click the menu icon the menu shows like drawer
                        // Also we want to hide this menu icon on desktop
                        if (!Responsive.isDesktop(context))
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                      ],
                    ),
                  ),
                  Expanded(child: MainScreenPage())
                ],
              ))),
    );
  }
}
