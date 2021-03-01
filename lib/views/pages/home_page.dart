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
    return Scaffold(
      appBar: appBar(context, 'Sales Snap'),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: 1500,
          padding: EdgeInsets.only(left: 12, right: 12, top: 12),
          child: GetBuilder<HomeController>(builder: (homecontroller) {
            return Column(
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
                            controller: homecontroller.textEditingController,
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
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(22)),
                      height: 40,
                      color: Colors.green,
                      child: Text('Go'),
                      onPressed: () async {
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
                GetBuilder<HomeController>(builder: (controller) {
                  if (controller.showProgress) {
                    return progressBar();
                  } else {
                    return controller.enable
                        ? productWidget(homecontroller, lable, context)
                        : getRecentSave(bodyStyle);
                  }
                }),
                SizedBox(
                  height: 12,
                ),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () {},
          ),
          SizedBox(width: 24),
          FloatingActionButton(
            child: Icon(Icons.web),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Column productWidget(
      HomeController homecontroller, TextStyle lable, BuildContext context) {
    return Column(
      children: [
        Image.network(homecontroller.imageUrl ?? img),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              homecontroller.price ?? '',
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
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(22)),
              color: Colors.green,
              child: Text('Visit Site'),
              onPressed: () {
                _routes.to(context, ItemDetailsPage());
              },
            ),
            SizedBox(
              width: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(22)),
              color: Colors.green,
              child: Text('Save'),
              onPressed: () async {
                // SystemAlertWindow.closeSystemWindow();
                //String path = await NativeScreenshot.takeScreenshot();
                //print(path.toString());
                print('-------save---------');
                homecontroller.saveProduct();
              },
            )
          ],
        ),
      ],
    );
  }

  Widget getRecentSave(bodyStyle) {
    return Expanded(
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
        itemCount: 10,
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
