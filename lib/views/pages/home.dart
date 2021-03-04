import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    final lable = Theme.of(context).textTheme.headline1;
    return GetBuilder<HomeController>(builder: (homecontroller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Form(
                          key: formKey,
                          child: Expanded(
                            flex: 5,
                            child: Container(
                              height: 44,
                              child: TextFormField(
                                controller:
                                    homecontroller.textEditingController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Url is Empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter URL of Product',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(22)),
                          height: 40,
                          color: Colors.green,
                          child: Text('Go'),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState.validate()) {
                              homecontroller.fetch();
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    homecontroller.enable
                        ? productWidget(homecontroller, lable, context)
                        : getRecentSave(bodyStyle),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
                homecontroller.showProgress
                    ? Positioned(
                        top: 50,
                        left: Get.width / 2 - 50,
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
        floatingActionButton: homecontroller.enable
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(22)),
                    )),
                    onPressed: () {
                      homecontroller.saveProduct();
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text("Save"),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(22)),
                    )),
                    onPressed: () {},
                    icon: Icon(Icons.public),
                    label: Text("WebSite"),
                  ),
                ],
              )
            : Container(),
      );
    });
  }

  Column productWidget(
      HomeController homecontroller, TextStyle lable, BuildContext context) {
    return Column(
      children: [
        Column(
          children: homecontroller.imageUrls
              .map(
                (image) => Image.network(image),
              )
              .toList(),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              homecontroller.price.toString(),
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
        Text(homecontroller.title[0],
            style:
                lable.copyWith(height: 1.5, wordSpacing: 1, letterSpacing: 1)),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget getRecentSave(TextStyle bodyStyle) {
    // print('------------------');
    //print(_homeController.saveList.length);
    return _homeController.saveList.length == 0
        ? Container(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text('You have not save any product.'),
            ))
        : Container(
            height: Get.height,
            width: Get.width,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          _homeController.saveList[index].imgUrl,
                          height: 100,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          _homeController.saveList[index].title,
                          style: bodyStyle.copyWith(fontSize: 14),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          _homeController.saveList[index].price,
                          style: bodyStyle.copyWith(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: _homeController.saveList.length,
            ),
          );
  }
}
