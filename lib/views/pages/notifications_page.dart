import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Notification'),
      body: Container(
        child: GetBuilder<SavedController>(
            init: SavedController(),
            builder: (controller) {
              return controller.notificationList.isEmpty
                  ? Center(
                      child: Text('No Notifications'),
                    )
                  : controller.isLoading
                      ? progressBar()
                      : ListView.builder(
                          itemCount: controller.notificationList.length,
                          itemBuilder: (context, index) {
                            return SavedTileWidget();
                          },
                        );
            }),
      ),
    );
  }
}

class SavedTileWidget extends StatelessWidget {
  const SavedTileWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.headline2;
    final bodyText = Theme.of(context).textTheme.bodyText2;
    return Container(
      height: 135,
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
              // Image.network(
              //   'https://cdn.shopify.com/s/files/1/1083/6796/products/product-image-187878776_400x.jpg?v=1569388351',
              //   width: 110,
              //   height: 110,
              // ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        'AvaCado',
                        style: title.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        '16\$',
                        style: title.copyWith(color: Colors.red),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'The item you saved, now its price is down',
                    maxLines: 2,
                    style: bodyText.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text('coupon: '),
                      Text('SDD333332DSD23'),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 200,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: Colors.blueAccent)),
                          onPressed: () {},
                          child: Text('Buy Now'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
