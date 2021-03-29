import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class BuyedTab extends StatelessWidget {
  const BuyedTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<SavedController>(
            init: SavedController(),
            builder: (controller) {
              return controller.buyItemList.isEmpty
                  ? Center(
                      child: Text('No Buy History'),
                    )
                  : ListView.builder(
                      itemCount: controller.buyItemList.length,
                      itemBuilder: (context, index) {
                        return BuyedTileWidget(
                          buyModel: controller.buyItemList[index],
                        );
                      },
                    );
            }));
  }
}

class BuyedTileWidget extends StatelessWidget {
  final BuyModel buyModel;

  BuyedTileWidget({
    Key key,
    this.buyModel,
  }) : super(key: key);

  final controller = Get.put(HomeController());

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
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          buyModel
                              .timestamp
                              .toDate()
                              .toLocal()
                              .toString()
                              .substring(0, 9),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      buyModel.title,
                      style: title,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text('Price'),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          buyModel.price,
                          maxLines: 1,
                          style: title.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
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
                            controller.deleteBuyProduc(buyModel.docId).then((value) {
                               Get.showSnackbar(
                                GetBar(
                                  message: "Scucessfully Item Deleted",
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            });
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
