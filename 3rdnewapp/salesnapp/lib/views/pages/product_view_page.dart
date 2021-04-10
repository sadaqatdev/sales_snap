import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/models/save_product_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/pages/items_details_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';

class ProductViewPage extends StatelessWidget {
  final SavedProductModel savedProductModel;
  final FireStoreMethod method=FireStoreMethod();
  ProductViewPage({this.savedProductModel});
  @override
  Widget build(BuildContext context) {
    final lable = Theme.of(context).textTheme.headline1;
    return Scaffold(
        appBar: appBar(
            action: SizedBox(),
            context: context,
            height: 110,
            leading: InkWell(onTap: (){Get.back();},child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white)),
            title: 'Item Details'),
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Stack(
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.only(
                    top: 100, left: 16, right: 20, bottom: 80),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Price'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            savedProductModel.price,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(savedProductModel.title.trim(),
                          style: lable.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.5)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              lable: 'Buy',
                              onPress: () {
                                method.buyButtonClick();
                                AppRoute.to(
                                    context,
                                    ItemDetailsPage(
                                      product: NotificationModel(
                                          avatarUrl: savedProductModel.imgUrl,
                                          cuponCode: '',
                                          desc: '',
                                          docId: '',
                                          newPrice: '',
                                          price: savedProductModel.price,
                                          priceHtmlTag:
                                              savedProductModel.priceHtmlTag,
                                          productTitle:
                                              savedProductModel.title,
                                          timestamp:
                                              savedProductModel.timestamp,
                                          title: '',
                                          webUrl: savedProductModel.webUrl),
                                    ));
                              },
                              color: Colors.black,
                              radius: 22),
                          SizedBox(
                            width: 22,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
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
                      child: OctoImage(
                        image: NetworkImage(savedProductModel.imgUrl),
                        placeholderBuilder: OctoPlaceholder.blurHash(
                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                        ),
                        errorBuilder: OctoError.icon(color: Colors.red),
                        fit: BoxFit.cover,
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
