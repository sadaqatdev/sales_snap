import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/views/pages/price_quaterly.dart';

import 'price_monthly.dart';
import 'price_weekly.dart';

class PriceSavingTab extends StatefulWidget {
  @override
  _PriceSavingTabState createState() => _PriceSavingTabState();
}

class _PriceSavingTabState extends State<PriceSavingTab> {
  DateTime date=DateTime.now();

  String returnMonth(DateTime date) {
  return new DateFormat.MMMM().format(date);
}

DateTime prevMonth  ;
DateTime prevMonth2  ;
@override
  void initState() {
 prevMonth = new DateTime(date.year, date.month - 1, date.day);
 prevMonth2 = new DateTime(date.year, date.month - 2, date.day);
    super.initState();
  }
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
                  child: Text(returnMonth(prevMonth2)),
                ),
                Tab(
                  child: Text(returnMonth(prevMonth)),
                ),
                Tab(
                  child: Text(returnMonth(DateTime.now())),
                 )
              ],
            ),
          ),
          body: TabBarView(
            children: [PreviousMonthTwo(), PreviosOne(), CurrentMonth()],
          ),
        ),
      ),
    );
  }
}
