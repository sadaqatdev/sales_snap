import 'package:flutter/material.dart';

import 'package:sales_snap_dashboard/views/pages/buy_tab.dart';
import 'package:sales_snap_dashboard/views/pages/saved_tab.dart';

class UserDetails extends StatelessWidget {
  final String uid;
  const UserDetails({
    Key key,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: TabBar(
              tabs: [
                Tab(
                  child: Text('Saved Items'),
                ),
                Tab(child: Text('Buyed Items'))
              ],
            ),
          ),
          body: TabBarView(
            children: [SavedTab(uid: uid,), BuyTab(uid: uid,)],
          ),
        ),
      ),
    );
  }
}
