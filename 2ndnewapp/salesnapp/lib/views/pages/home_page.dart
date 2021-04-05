import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/utils/dateformate.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/pages/product_page.dart';
import 'package:sales_snap/views/pages/product_view_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';

class HomePage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final _homeController = Get.put(HomeController());
  double height = Get.height;

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    final forteenFont = Theme.of(context).textTheme.bodyText1;
    final lable = Theme.of(context).textTheme.headline1;

    return GetBuilder<SavedController>(
        init: SavedController(),
        builder: (saveController) {
          print(height);
          return Stack(
            children: [
              Scaffold(
                appBar: appBar(
                  context: context,
                  title: '',
                  height: 130,
                  action: SizedBox(),
                ),
                body: Container(
                  padding: EdgeInsets.only(
                      left: 12, right: 12, top: 170, bottom: 10),
                  color: Color(0xffE5E5E5),
                  child: getRecentSave(saveController, bodyStyle),
                ),
              ),
              Positioned(
                  top: (height / _homeController.numb) - 40,
                  left: 12,
                  right: 12,
                  child: searchField(context, forteenFont)),
            ],
          );
        });
  }

  Widget searchField(BuildContext context, TextStyle forteenFont) {
    return Form(
      key: formKey,
      child: Container(
        height: 180,
        width: Get.width,
        margin: EdgeInsets.only(left: 6, right: 6),
        padding: EdgeInsets.only(top: 12, left: 20, right: 20),
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
        child: Column(
          children: [
            Text('Paste a link',
                style: GoogleFonts.rubik().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1B1B4E))),
            SizedBox(
              height: 16,
            ),
            Text(
              'Copy and paste your link below',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik().copyWith(
                  fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffF6F6FC)),
                    child: TextFormField(
                      obscureText: false,
                     
                      keyboardType: TextInputType.text,
                      controller: HomeController.to.textEditingController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Product Url';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Paste Link',
                        hintStyle: GoogleFonts.montserrat(fontSize: 14),
                        suffixIcon: InkWell(
                            onTap: () {
                              HomeController.to.textEditingController.clear();
                            },
                            child: Icon(Icons.close)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                buildMaterialButton(context, forteenFont)
              ],
            )
          ],
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
        minWidth: 20,
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
              child: Text('You have not saved any product.'),
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
                  child: InkWell(
                    onTap: () {
                      AppRoute.to(
                          context,
                          ProductViewPage(
                            savedProductModel:
                                savedController.saveItemList[index],
                          ));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: OctoImage(
                              alignment: Alignment.center,
                              filterQuality: FilterQuality.high,
                              image: NetworkImage(
                                  savedController.saveItemList[index].imgUrl),
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                              ),
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'https://via.placeholder.com/350x150',
                                  fit: BoxFit.fill,
                                );
                              },
                              fit: BoxFit.fill,
                            ),
                          )),
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
                                  'Price ${savedController.saveItemList[index].price}',
                                  style: bodyStyle.copyWith(color: Colors.red),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(df
                                        .format(savedController
                                            .saveItemList[index].timestamp
                                            .toDate())
                                        .substring(0, 11))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
