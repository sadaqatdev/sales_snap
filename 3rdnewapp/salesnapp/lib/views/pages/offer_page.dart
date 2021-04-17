import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/items_details_page.dart';

import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';

class OfferPage extends StatelessWidget {
  final NotificationModel notificationModel;
  OfferPage({Key key, this.notificationModel}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  FireStoreMethod method = FireStoreMethod();
  @override
  Widget build(BuildContext context) {
    final lable = Theme.of(context).textTheme.headline1;
    final bodytext = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
        body: Stack(
      children: [
        Scaffold(
          appBar: appBar(
            context: context,
            title: 'You have an Offer',
            height: 100,
            action: SizedBox(),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: Get.width,
              padding:
                  EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 20),
              child: Column(
                children: [
                  productWidget(lable, context),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: Get.width,
                    child: Card(
                      color: AppTheme.customColorOne,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      margin: EdgeInsets.only(
                        top: 22,
                        left: 16,
                        right: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.card_giftcard_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 23,
                                ),
                                Expanded(
                                  child: Text(
                                    notificationModel.validDate ??
                                        '--',
                                    style: bodytext,
                                  ),
                                   
                                )
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     MaterialButton(
                            //       color: Colors.white,
                            //       padding: EdgeInsets.only(top: 16, bottom: 16),
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(12),
                            //               bottomLeft: Radius.circular(12))),
                            //       onPressed: () {},
                            //       child: Text('23hrs'),
                            //     ),
                            //     SizedBox(
                            //       width: 1,
                            //     ),
                            //     MaterialButton(
                            //       color: Colors.white,
                            //       padding: EdgeInsets.only(top: 16, bottom: 16),
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.only(
                            //               topRight: Radius.circular(12),
                            //               bottomRight: Radius.circular(12))),
                            //       onPressed: () {},
                            //       child: Text('23hrs'),
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  Widget productWidget(TextStyle lable, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.only(
              top: 100,
              left: 16,
              right: 20,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Text(notificationModel.timestamp
                          .toDate()
                          .toString()
                          .substring(0, 19)),
                          Spacer(),
                          Text(
                                    notificationModel.price ??
                                        ' ',
                                     
                                  ),
                                  SizedBox(width: 16,)
                    ],
                  ),
                  Text('You have an Offer',
                      style: lable.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.5)),
                  SizedBox(
                    height: 12,
                  ),
                     Text('Hey ,'),
                     SizedBox(
                    height: 12,
                  ),
                  Text(notificationModel.title,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),),
               
                  SizedBox(
                    height: 12,
                  ),
                  Text(notificationModel.desc),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Code:'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(notificationModel.cuponCode),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          lable: 'Copy Code',
                          onPress: () {
                            print('---------------');
                            Clipboard.setData(new ClipboardData(
                                text: notificationModel.cuponCode ??
                                    "your text"));
                            Get.showSnackbar(GetBar(
                              message: 'Copun is Copy to Clipboard',
                              duration: Duration(seconds: 3),
                            ));
                          },
                          color: AppTheme.customColorThree,
                          radius: 8),
                      SizedBox(
                        width: 12,
                      ),
                      CustomButton(
                          lable: 'Buy',
                          onPress: () {
                            // method.setbuyItems(BuyModel(
                            //     desc: 'widget.product.desc',
                            //     imgUrl:
                            //         'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                            //     newPrice: '78',
                            //     price: '100',
                            //     priceHtmlTag: 'widget.product.priceHtmlTag',
                            //     title:
                            //         'Buy Smoby Tractor and Trailor Ride On | Ride-ons | Argos',
                            //     priceNumber: '100',
                            //     timestamp: Timestamp.now(),
                            //     uid: FirebaseAuth.instance.currentUser.uid,
                            //     webUrl: 'sdsfds'));

                            method.buyButtonClick();
                            AppRoute.to(
                                context,
                                ItemDetailsPage(
                                  product: notificationModel,
                                ));
                          },
                          color: Colors.black,
                          radius: 8),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                  SizedBox(height: 17)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: (Get.width / 2) - 120,
          child: Container(
            height: 198,
            width: 223,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              child: Image.network(
                notificationModel.avatarUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )
      ],
    );
  }
}