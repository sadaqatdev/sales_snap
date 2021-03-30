import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_snap/controllers/notification_controller.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/offer_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';

class NotificationPage extends StatelessWidget {
  final notifica = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: 'Notifications',
          height: 100,
          action: SizedBox()),
      body: Container(
        child: GetX<NotificationController>(builder: (controller) {
          if (controller != null && controller.notificationList.value != null) {
            if (controller.notificationList.value.isEmpty) {
              return Center(
                child: Text('Empty Notifications'),
              );
            }
            return ListView.builder(
              itemCount: controller.notificationList.value.length,
              itemBuilder: (context, index) {
                return SavedTileWidget(
                  notificationModel: controller.notificationList.value[index],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}

class SavedTileWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  SavedTileWidget({Key key, this.notificationModel}) : super(key: key);
  final FireStoreMethod method = FireStoreMethod();
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.headline2;
    final bodyText = Theme.of(context).textTheme.bodyText2;
    return Container(
      height: 160,
      width: Get.width,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                notificationModel.avatarUrl ??
                    'https://artgalleryofballarat.com.au/wp-content/uploads/2020/06/placeholder-image.png',
                width: 130,
                height: 130,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(df.format(notificationModel.timestamp.toDate()).substring(0,11)),
                        SizedBox(
                          width: 18,
                        )
                      ],
                    ),
                    SizedBox(width: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notificationModel.productTitle ?? 'No Tile',
                            maxLines: 3,
                            style: title.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(notificationModel.cuponCode),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(notificationModel.price),
                        Spacer(),
                        Container(
                          height: 45,
                          width: 80,
                          child: MaterialButton(
                            color: AppTheme.customColorThree,
                            padding: EdgeInsets.only(top: 16, bottom: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            onPressed: () {
                              Get.to(() => OfferPage(
                                    notificationModel: notificationModel,
                                  ));
                            },
                            child: Text(
                              'View Offer',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              method
                                  .deleteNotifications(notificationModel.docId)
                                  .then((value) {
                                Get.showSnackbar(
                                  GetBar(
                                    message: "Scucessfully Item Deleted",
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
