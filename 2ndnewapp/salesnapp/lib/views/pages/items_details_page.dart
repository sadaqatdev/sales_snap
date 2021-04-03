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
    return Scaffold(
      key: scafoldKey,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebView(
                  initialUrl: widget.product.webUrl,
                  onWebViewCreated: (WebViewController _webViewController) {
                    webViewcontroller = _webViewController;
                  },
                  navigationDelegate: (NavigationRequest request) {
                    print('=================================');
                    if (request.url.contains('success') ||
                        request.url.contains('order-received') ||
                        request.url.contains('order') ||
                        request.url.contains('completed') ||
                        request.url.contains('payment')) {
                      print('--------------sucess-------------');
                      method.sucessfullBuy();
                      method
                          .setbuyItems(BuyModel(
                              desc: widget.product.desc,
                              imgUrl: widget.product.avatarUrl,
                              newPrice: widget.product.newPrice ?? '0',
                              price: widget.product.price ?? '0',
                              priceHtmlTag: widget.product.priceHtmlTag,
                              title: widget.product.title,
                              priceNumber: widget.product.price ?? '0',
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
                onPressed: () async {
                  bool go = await webViewcontroller.canGoBack();
                  if (go) {
                    webViewcontroller?.goBack();
                  } else {
                    Navigator.of(context).pop();
                  }
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
    );
  }
}
