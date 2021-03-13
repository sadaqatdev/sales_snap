import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/pages/product_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';

class HomePage extends StatelessWidget {
  final Routes _routes = Routes();

  final formKey = GlobalKey<FormState>();

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    final forteenFont = Theme.of(context).textTheme.bodyText1;
    final lable = Theme.of(context).textTheme.headline1;

    return GetBuilder<SavedController>(
        init: SavedController(),
        builder: (saveController) {
          return Stack(
            children: [
              Scaffold(
                appBar: appBar(
                  context: context,
                  title: 'Sales Snap',
                  height: 150,
                  action: SizedBox(),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            getRecentSave(saveController, bodyStyle),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 134,
                left: 12,
                right: 12,
                child: searchField(context, forteenFont),
              ),
            ],
          );
        });
  }

  Widget searchField(BuildContext context, TextStyle forteenFont) {
    return Form(
      key: formKey,
      child: Container(
        height: 90,
        width: Get.width,
        margin: EdgeInsets.only(left: 6, right: 6),
        padding: EdgeInsets.only(top: 22, bottom: 22, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: TextFormField(
            controller: HomeController.to.textEditingController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Url is Empty';
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Color(0xffF6F7F8),
              prefixIcon: Icon(
                Icons.search,
                size: 24,
              ),
              suffixIcon: buildMaterialButton(context, forteenFont),
              hintText: 'Paste Link',
              hintStyle: forteenFont.copyWith(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff9F9F9F)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMaterialButton(BuildContext context, TextStyle forteenFont) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        height: 35,
        color: Colors.black,
        child: Text(
          'Go',
          style: forteenFont,
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (formKey.currentState.validate()) {
            Get.to(() => ProductPage());

            HomeController.to.fetch();
          }
        },
      ),
    );
  }

  Widget getRecentSave(SavedController savedController, TextStyle bodyStyle) {
    // print('------------------');
    //print(_homeController.saveList.length);
    return savedController.saveItemList.length == 0
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
                        Expanded(
                          child: Image.network(
                            savedController.saveItemList[index].imgUrl,
                            width: 170,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                savedController.saveItemList[index].title,
                                style: bodyStyle.copyWith(fontSize: 14),
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                savedController.saveItemList[index].price,
                                style: bodyStyle.copyWith(color: Colors.red),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: savedController.saveItemList.length,
            ),
          );
  }
}

// ElevatedButton.icon(
//   onPressed: () {
//     print(" 🚀 debuging at line 106");
//     webViewcontroller.evaluateJavascript('''
//         window.SNAP.postMessage(document.querySelectorAll("*[class*=\'price\']")[0].innerText);
//         window.SNAP.postMessage(document.querySelectorAll(".pdp img")[0].getAttribute('srcset').split('w,')[0]);
//         ''');
//   },
//   icon: Text("🚀 "),
//   label: Text("Load"),
// ),
// Expanded(
//   child: WebView(
//     gestureNavigationEnabled: true,
//     javascriptMode: JavascriptMode.unrestricted,
//     javascriptChannels: [
//       JavascriptChannel(
//           name: 'SNAP',
//           onMessageReceived: (message) {
//             print('-------in snap---------------');
//             print(message.message);
//           })
//     ].toSet(),
//     onPageFinished: (url) {
//       print(" 🚀 debuging at line 106");
//       webViewcontroller.evaluateJavascript(
//           'window.SNAP.postMessage(document.querySelectorAll("*[class*=\'price\']")[0].innerText);');
//     },
//     onWebViewCreated: (WebViewController _webViewController) {
//       webViewcontroller = _webViewController;
//     },
//     initialUrl:
//         'https://shop.lululemon.com/p/mens-jackets-and-outerwear/Expeditionist-Anorak/_/prod10370103?color=0001',
//   ),
// ),