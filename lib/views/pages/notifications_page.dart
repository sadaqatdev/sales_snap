import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/offer_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: 'Notifications',
          height: 100,
          action: SizedBox()),
      body: Container(
        child: GetBuilder<SavedController>(
            init: SavedController(),
            builder: (controller) {
              // return controller.notificationList.isEmpty
              //     ? Center(
              //         child: Text('No Notifications'),
              //       )
              //     : controller.isLoading
              //         ? progressBar()
              //         :
              return ListView.builder(
                itemCount: 12,
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
              Image.network(
                'https://cdn.shopify.com/s/files/1/1083/6796/products/product-image-187878776_400x.jpg?v=1569388351',
                width: 130,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'AvaCado',
                          style: title.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text('SDD333332DSD23'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 45,
                          width: 86,
                          child: MaterialButton(
                            color: AppTheme.customColorThree,
                            padding: EdgeInsets.only(top: 16, bottom: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            onPressed: () {
                              Get.to(() => OfferPage());
                            },
                            child: Text(
                              'View Offer',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
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
