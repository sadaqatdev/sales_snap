import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/views/widgets/buyed_widget.dart';
import 'package:sales_snap/views/widgets/saved_widget.dart';

class MyItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SavedController());

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
              child: TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: Text('Saved Items'),
                  ),
                  Tab(child: Text('Buyed Items'))
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [SavedTab(), BuyedTab()],
          ),
        ),
      ),
    );
  }
}
