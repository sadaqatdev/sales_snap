import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/notification_model.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class NotificationPage extends StatelessWidget {
  FirestoreMethods _methods = FirestoreMethods();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: FutureBuilder<List<NotificationModel>>(
          future: _methods.getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text('No Notifcations'),
                );
              }
              return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: 16,
                          ),
                          height: 140,
                          child: Card(
                            margin: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Notification Title'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(snapshot.data[index].title ?? '')
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Text('Notification Desc'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(snapshot.data[index].desc ?? '')
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Text('Notification Cupon Code'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(snapshot.data[index].cuponCode ?? '')
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Text('Notification WebUrl'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(snapshot.data[index].webUrl ?? '')
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                )
                              ],
                            ),
                          ),
                        );
                      }));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
// String title;
//   String desc;
//   String cuponCode;
//   String price;
//   String webUrl;
