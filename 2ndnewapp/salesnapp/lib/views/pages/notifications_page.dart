import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_snap/controllers/notification_controller.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/offer_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
                  onpress: (){
                    setState(() {
                                          
                                        });
                  },
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

class SavedTileWidget extends StatefulWidget {
  final NotificationModel notificationModel;
  final Function onpress;
  SavedTileWidget({Key key, this.notificationModel,this.onpress}) : super(key: key);

  @override
  _SavedTileWidgetState createState() => _SavedTileWidgetState();
}

class _SavedTileWidgetState extends State<SavedTileWidget> {
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
                widget.notificationModel.avatarUrl ??
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
                        Text(df.format(widget.notificationModel.timestamp.toDate()).substring(0,11)),
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
                            widget.notificationModel.productTitle ?? 'No Tile',
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
                          Text(widget.notificationModel.cuponCode),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.notificationModel.price),
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
                              method.updateNotificationSatus(widget.notificationModel.docId);
                              Get.to(() => OfferPage(
                                    notificationModel: widget.notificationModel,
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
                                  .deleteNotifications(widget.notificationModel.docId)
                                  .then((value) {
                               widget.onpress();
                                Get.showSnackbar(
                                  GetBar(
                                    message: "Item successfully deleted",
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
