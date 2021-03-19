import 'package:flutter/material.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/models/web_details.dart';
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

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    scafoldKey = GlobalKey<ScaffoldState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

                        Navigator.of(context).pop();
                      } else if (request.url.contains('cancel') ||
                          request.url.contains('order-received')) {
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
