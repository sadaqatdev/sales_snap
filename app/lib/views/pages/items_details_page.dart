import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemDetailsPage extends StatefulWidget {
  final NotificationModel product;
  ItemDetailsPage({this.product});
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  WebViewController webViewcontroller;

  double progress;

  GlobalKey<ScaffoldState> scafoldKey;

  bool isLoading = true;

  FireStoreMethod method = FireStoreMethod();
  final storage = GetStorage();

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    scafoldKey = GlobalKey<ScaffoldState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uid = storage.read('uid');
    return SafeArea(
      child: Scaffold(
        key: scafoldKey,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WebView(
                    initialUrl: 'https://www.threadandthread.com/my-account/',
                    onWebViewCreated: (WebViewController _webViewController) {
                      webViewcontroller = _webViewController;
                    },
                    navigationDelegate: (NavigationRequest request) {
                      print('=================================');
                      if (request.url.contains('success') ||
                          request.url.contains('order-received') ||
                          request.url.contains('order')) {
                        print('--------------sucess-------------');

                        method
                            .setbuyItems(BuyModel(
                                desc: widget.product.desc,
                                imgUrl: widget.product.avatarUrl,
                                newPrice: widget.product.newPrice,
                                price: widget.product.price,
                                priceHtmlTag: widget.product.priceHtmlTag,
                                title: widget.product.title,
                                priceNumber: widget.product.price,
                                uid: uid,
                                webUrl: widget.product.webUrl))
                            .then((value) {
                          SavedController.to.getBuyList();
                        });
                      } else if (request.url.contains('cancel')) {
                        print('-------------fail------------');
                      }
                      return NavigationDecision.navigate;
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onPageFinished: (url) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  isLoading
                      ? Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    webViewcontroller?.goBack();
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    webViewcontroller?.goForward();
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    webViewcontroller?.reload();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
