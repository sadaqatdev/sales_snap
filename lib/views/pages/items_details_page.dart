import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  WebViewController webViewcontroller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: [
          JavascriptChannel(
              name: 'SNAP',
              onMessageReceived: (message) {
                print('-------in snap---------------');
                print(message.message);
              })
        ].toSet(),
        onPageFinished: (url) {
          print(" 🚀 debuging at line 106");
          webViewcontroller.evaluateJavascript(
              'window.SNAP.postMessage(document.querySelectorAll("*[class*=\'price\']")[0].innerText);');
        },
        onWebViewCreated: (WebViewController _webViewController) {
          webViewcontroller = _webViewController;
        },
        initialUrl:
            'https://shop.lululemon.com/p/mens-jackets-and-outerwear/Expeditionist-Anorak/_/prod10370103?color=0001',
      ),
    );
  }
}
