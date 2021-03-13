import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemDetailsPage extends StatefulWidget {
  final String url;
  ItemDetailsPage({this.url});
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
    return SafeArea(
      child: Container(
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
          initialUrl: widget.url,
          gestureRecognizers: Set()
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()
              ..onTapDown = (tap) {
                print('----------Tap');
                webViewcontroller.evaluateJavascript(
                    'window.SNAP.postMessage(document.querySelectorAll("*[class*=\'price\']")[0].innerText);');
              })),
        ),
      ),
    );
  }
}
