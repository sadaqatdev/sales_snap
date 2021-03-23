import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/widgets/buyed_widget.dart';
import 'package:sales_snap/views/widgets/saved_widget.dart';

import 'price_monthly.dart';
import 'price_weekly.dart';

class PriceSavingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SavedController());

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffE5E5E5),
            flexibleSpace: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text('Weekly'),
                ),
                Tab(
                  child: Text('Monthly'),
                ),
                Tab(
                  child: Text('Quaterly'),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [PriceWeekly(), PriceMonthly(), PriceWeekly()],
          ),
        ),
      ),
    );
  }
}
