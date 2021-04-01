import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/buy_controller.dart';
import 'package:sales_snap_dashboard/models/buy_model.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';

import 'package:sales_snap_dashboard/views/widgets/search_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyPage extends StatelessWidget {
  BuyPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height,
        child: GetBuilder<BuyController>(
            init: BuyController(),
            builder: (controller) {
              return controller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        SearchWidget(
                          controller: controller.controller,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        controller.buySearchList.isEmpty
                            ? Center(
                                child: Text('Empty'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: controller.buySearchList.length,
                                  itemBuilder: (context, index) {
                                    return BuyTile(
                                      saveItemList:
                                          controller.buySearchList[index],
                                      isSelectedFuntction: (value) {},
                                      key: Key(index.toString()),
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
            }));
  }
}

class BuyTile extends StatefulWidget {
  final BuyModel saveItemList;

  final Key key;
  final ValueChanged<bool> isSelectedFuntction;

  BuyTile({
    this.saveItemList,
    this.key,
    this.isSelectedFuntction,
  }) : super(key: key);

  @override
  _SavedTileWidgetState createState() => _SavedTileWidgetState();
}

class _SavedTileWidgetState extends State<BuyTile> {
  bool isSelected = false;

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
                'https://fakeimg.pl/300/',
                fit: BoxFit.fill,
                width: 150,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.saveItemList.title,
                          style: title.copyWith(fontSize: 18),
                          maxLines: 3,
                        ),
                        Spacer(),
                        Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                isSelected = value;

                                widget.isSelectedFuntction(value);
                              });
                            }),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            "https://www.youtube.com/channel/UCwxiHP2Ryd-aR0SWKjYguxw?view_as=subscriber",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url =
                                "https://www.youtube.com/channel/UCwxiHP2Ryd-aR0SWKjYguxw?view_as=subscriber";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ])),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '1200 USD',
                          maxLines: 1,
                          style:
                              title.copyWith(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
