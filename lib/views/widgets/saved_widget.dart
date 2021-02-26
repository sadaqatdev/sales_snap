import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/web_details.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<SavedController>(builder: (controller) {
          return ListView.builder(
            itemCount: controller.saveItemList.length,
            itemBuilder: (context, index) {
              return SavedTileWidget(
                  saveItemList: controller.saveItemList, index: index);
            },
          );
        }));
  }
}

class SavedTileWidget extends StatelessWidget {
  final List<WebDetails> saveItemList;
  final index;
  const SavedTileWidget({
    Key key,
    this.index,
    this.saveItemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.headline2;
    final bodyText = Theme.of(context).textTheme.bodyText2;
    return Container(
      height: 115,
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
                saveItemList[index].imgUrl,
                width: 110,
                height: 110,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        saveItemList[index].title.substring(0, 10),
                        style: title.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(width: 10),
                      Text(
                        saveItemList[index].priceHtmlTag,
                        style: title.copyWith(color: Colors.red),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Expanded(
                    child: Text(
                      saveItemList[index].desc.substring(0, 10),
                      style: bodyText.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(saveItemList[index].webUrl),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
