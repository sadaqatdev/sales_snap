import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/send_notification.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sales_snap_dashboard/controller/save_controller.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';
import 'package:sales_snap_dashboard/views/widgets/search_widget.dart';

class SavedTab extends StatelessWidget {
  final String uid;
  const SavedTab({
    Key key,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          child: GetBuilder<SaveController>(
              init: SaveController(uid: uid),
              builder: (bcontroller) {
                return bcontroller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          // SearchWidget(
                          //   controller: bcontroller.controller,
                          // ),
                          SizedBox(
                            height: 12,
                          ),
                          bcontroller.viseble
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MaterialButton(
                                      color: Colors.green,
                                      onPressed: () {
                                        /// bcontroller.sendNotification();
                                        dialog(
                                            context,
                                            bcontroller.selectedList,
                                            bcontroller.webUrl,
                                            bcontroller.uidList,
                                            bcontroller.avataUrl,
                                            bcontroller.priceHtmlTag,
                                            bcontroller.price,
                                            bcontroller.productTitle);
                                      },
                                      child: Text('Send Notification Message'),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 16,
                          ),
                          bcontroller.userSaveList.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: bcontroller.userSaveList.length,
                                    itemBuilder: (context, index) {
                                      return SavedTileWidget(
                                        saveItemList:
                                            bcontroller.userSaveList[index],
                                        isSelectedFuntction: (value) {
                                          print(
                                              bcontroller.selectedList.length);
                                          bcontroller.addToSelectList(
                                              bcontroller
                                                  .userSaveList[index].msgToken,
                                              value,
                                              bcontroller
                                                  .userSaveList[index].webUrl,
                                              bcontroller
                                                  .userSaveList[index].uid,
                                              bcontroller
                                                  .userSaveList[index].imgUrl,
                                              bcontroller.userSaveList[index]
                                                  .priceHtmlTag,
                                              bcontroller
                                                  .userSaveList[index].price,
                                              bcontroller
                                                  .searchList[index].title);
                                        },
                                        key: Key(index.toString()),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text('No Saved Items'),
                                ),
                        ],
                      );
              })),
    );
  }

  void dialog(
      BuildContext context,
      List<String> ids,
      String url,
      List<String> uidList,
      String avatarUrl,
      String priceHtmlTag,
      price,
      String productTitle) {
    var key = GlobalKey<FormState>();
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Builder(builder: (bcontext) {
            return Container(
              margin:
                  EdgeInsets.only(left: 200, right: 200, top: 300, bottom: 280),
              child: GetBuilder<SendNotification>(
                  init: SendNotification(
                      usersId: ids,
                      webUrl: url,
                      uidList: uidList,
                      avatarUrl: avatarUrl,
                      priceHtmlTag: priceHtmlTag,
                      price: price,
                      productTitle: productTitle),
                  builder: (snapshot) {
                    return Material(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: snapshot.titleControlller,
                                decoration: InputDecoration(
                                  hintText: 'Notification Title',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Notification Title';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.bodyController,
                                decoration: InputDecoration(
                                    hintText: 'Notification Body'),
                                maxLines: 3,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Notification Body';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.copunController,
                                decoration: InputDecoration(hintText: 'Code'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter code';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.validatinMessage,
                                decoration: InputDecoration(
                                    hintText: 'Validation Date and Message'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter code';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              snapshot.isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            if (key.currentState.validate()) {
                                              snapshot.sendNotification();
                                            }
                                          },
                                          child: Text('Send'),
                                        )
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          });
        });
  }
}

class SavedTileWidget extends StatefulWidget {
  final SaveListModel saveItemList;

  final Key key;

  final ValueChanged<bool> isSelectedFuntction;

  SavedTileWidget({
    this.saveItemList,
    this.key,
    this.isSelectedFuntction,
  }) : super(key: key);

  @override
  _SavedTileWidgetState createState() => _SavedTileWidgetState();
}

class _SavedTileWidgetState extends State<SavedTileWidget> {
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
              CachedNetworkImage(
                imageUrl: widget.saveItemList.imgUrl,
                fit: BoxFit.fill,
                height: 150,
                width: 150,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.network(
                    "https://image.shutterstock.com/z/stock-vector-default-ui-image-placeholder-for-wireframes-for-apps-and-websites-1037719192.jpg"),
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
                    Text(
                      widget.saveItemList.title ?? 'Title is not avalibale',
                      style: title.copyWith(fontSize: 18),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: widget.saveItemList.webUrl ??
                            'URL is not avalibale',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = widget.saveItemList.webUrl;
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
                          widget.saveItemList.price ?? 'Price is not avalibale',
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
