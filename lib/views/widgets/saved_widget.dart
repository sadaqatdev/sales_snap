import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/pages/items_details_page.dart';

class SavedTab extends StatelessWidget {
  SavedTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<SavedController>(builder: (controller) {
          return controller.saveItemList.isEmpty
              ? Center(
                  child: Text('No Saved Items'),
                )
              : ListView.builder(
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
  final List<SavedProduct> saveItemList;
  final index;
  SavedTileWidget({
    Key key,
    this.index,
    this.saveItemList,
  }) : super(key: key);

  final Routes _routes = Routes();

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.headline2;

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
              Image.network(
                saveItemList[index].imgUrl,
                width: 110,
                height: 110,
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
                      saveItemList[index].title,
                      style: title,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      saveItemList[index].price,
                      maxLines: 1,
                      style: title.copyWith(color: Colors.red),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(22)),
                          )),
                          onPressed: () {
                            _routes.to(
                                context,
                                ItemDetailsPage(
                                  url: saveItemList[index].webUrl,
                                ));
                          },
                          icon: Icon(Icons.badge),
                          label: Text("Buy"),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print('---------------------');
                            controller.deleteProduct(saveItemList[index].id);
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
