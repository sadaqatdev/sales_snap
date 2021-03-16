import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sales_snap/repositories/database_helper.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/items_details_page.dart';

import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';

class OfferPage extends StatelessWidget {
  final String avatarUrl;
  final String title;
  final String coupon;
  final String body;
  final String webUrl;
  OfferPage(
      {Key key,
      this.avatarUrl,
      this.title,
      this.coupon,
      this.body,
      this.webUrl})
      : super(key: key);

  final formKey = GlobalKey<FormState>();

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
                  // Container(
                  //   width: Get.width,
                  //   child: Card(
                  //     color: AppTheme.customColorOne,
                  //     elevation: 6,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(16)),
                  //     margin: EdgeInsets.only(
                  //       top: 22,
                  //       left: 16,
                  //       right: 20,
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 12, top: 12),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.card_giftcard_outlined,
                  //                 color: Colors.white,
                  //               ),
                  //               SizedBox(
                  //                 width: 23,
                  //               ),
                  //               Text(
                  //                 'This offer will expire in...',
                  //                 style: bodytext,
                  //               )
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 23,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               MaterialButton(
                  //                 color: Colors.white,
                  //                 padding: EdgeInsets.only(top: 16, bottom: 16),
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.only(
                  //                         topLeft: Radius.circular(12),
                  //                         bottomLeft: Radius.circular(12))),
                  //                 onPressed: () {},
                  //                 child: Text('23hrs'),
                  //               ),
                  //               SizedBox(
                  //                 width: 1,
                  //               ),
                  //               MaterialButton(
                  //                 color: Colors.white,
                  //                 padding: EdgeInsets.only(top: 16, bottom: 16),
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.only(
                  //                         topRight: Radius.circular(12),
                  //                         bottomRight: Radius.circular(12))),
                  //                 onPressed: () {},
                  //                 child: Text('23hrs'),
                  //               )
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 22,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
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
                  Text(desc),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Code:'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(coupon),
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
                            Clipboard.setData(
                                new ClipboardData(text: coupon ?? "your text"));
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
                            AppRoute.to(
                                context,
                                ItemDetailsPage(
                                  url: webUrl,
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
                avatarUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )
      ],
    );
  }
}
