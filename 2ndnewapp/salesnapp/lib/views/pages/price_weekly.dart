import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sales_snap/controllers/price_saving_controller.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';

class PreviousMonthTwo extends StatelessWidget {
  PreviousMonthTwo({
    Key key,
  }) : super(key: key);
  List<double> totalSaving = [];
  final d = Get.put(PriceSavingController());
  @override
  Widget build(BuildContext context) {
    return Container(child: GetX<PriceSavingController>(builder: (controller) {
      return controller.previosMonthTwo?.value?.isEmpty ?? false
          ? Center(
              child: Text('No Buy History'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'You Saved',
                    style: TextStyle(
                        fontSize: 15, color: AppTheme.customColorThree),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    '£ ${controller.weeklyTotal}',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.previosMonthTwo?.value?.length??0,
                    itemBuilder: (context, index) {
                      totalSaving.add(double.parse(controller
                              .previosMonth.value[index].priceNumber) -
                          double.parse(controller
                              .previosMonth.value[index].newPrice));

                      return BuyedTileWidget(
                        buyModel: controller.previosMonthTwo.value[index],
                      );
                    },
                  ),
                ),
              ],
            );
    }));
  }

  double get total =>
      totalSaving.fold(0, (previousValue, element) => previousValue + element);
}

class BuyedTileWidget extends StatelessWidget {
  final BuyModel buyModel;

  BuyedTileWidget({
    Key key,
    this.buyModel,
  }) : super(key: key);

  final methods = FireStoreMethod();

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.headline2.copyWith(
          color: Colors.black,
        );

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OctoImage(
                width: 100,
                height: 100,
                image: NetworkImage(buyModel.imgUrl),
                placeholderBuilder: OctoPlaceholder.blurHash(
                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Image.network('https://via.placeholder.com/150');
                },
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      buyModel.title,
                      style: title,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text('You saved '),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          (double.parse(buyModel.priceNumber) -
                                  double.parse(buyModel.newPrice))
                              .toString(),
                          maxLines: 1,
                          style: title.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print('---------------------');
                            methods.deletePriceSaving(buyModel.docId);
                          },
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

// class BuyedTileWidget extends StatelessWidget {
//   final BuyModel buyModel;
//   const BuyedTileWidget({Key key, this.buyModel}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 8, right: 8),
//       child: Card(
//           elevation: 6,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Image.network(
//                 buyModel.imgUrl ??
//                     'https://cdn.shopify.com/s/files/1/1083/6796/products/product-image-187878776_400x.jpg?v=1569388351',
//                 width: 100,
//                 height: 100,
//               ),
//               SizedBox(
//                 width: 12,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     buyModel.title ?? '',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Text(
//                     buyModel.desc ?? '',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Text(
//                     buyModel.price,
//                     style: TextStyle(fontSize: 12),
//                   )
//                 ],
//               )
//             ],
//           )),
//     );
//   }
// }
