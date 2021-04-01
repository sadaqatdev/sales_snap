import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/navigation_controller.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<NavigationController>(
          init: NavigationController(),
          builder: (controller) {
            return controller.currentPage;
          },
        ));
  }
}
