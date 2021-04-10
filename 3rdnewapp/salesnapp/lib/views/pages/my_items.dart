import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/views/pages/price_saving_tabs.dart';
import 'package:sales_snap/views/widgets/buyed_widget.dart';
import 'package:sales_snap/views/widgets/saved_widget.dart';

class MyItemPage extends StatelessWidget {
  double marginTop;
  @override
  Widget build(BuildContext context) {
    Get.put(SavedController());
    if(Platform.isAndroid){
      marginTop=80;
    }else{
      marginTop=50;
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24))),
          flexibleSpace: Padding(
            padding:  EdgeInsets.only(top: marginTop, left: 12, right: 12),
            child: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(child: Text('Saved')),
                Tab(child: Text('Purchased')),
                Tab(child: Text('Savings'))
              ],
            ),
          ), 
        ),
        body: TabBarView(
          children: [SavedTab(), BuyedTab(), PriceSavingTab()],
        ),
      ),
    );
  }
}
