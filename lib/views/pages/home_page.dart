import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/pages/items_details_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatelessWidget {
  final Routes _routes = Routes();

  WebViewController webViewcontroller;
  final formKey = GlobalKey<FormState>();
  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    final lable = Theme.of(context).textTheme.headline1;
    return GetBuilder<HomeController>(builder: (homecontroller) {
      return Scaffold(
        appBar: appBar(context, 'Sales Snap'),
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
                        child: progressBar(),
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
                    onPressed: () {
                      if (formKey.currentState.validate())
                        _routes.to(
                            context,
                            ItemDetailsPage(
                              url: homecontroller.textEditingController.text,
                            ));
                    },
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
              homecontroller.price.toString() ?? '',
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
        Text(homecontroller.title ?? '',
            style:
                lable.copyWith(height: 1.5, wordSpacing: 1, letterSpacing: 1)),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget getRecentSave(bodyStyle) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.81,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(img),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Lulolamenon',
                  style: bodyStyle,
                )
              ],
            ),
          );
        },
        itemCount: 12,
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
