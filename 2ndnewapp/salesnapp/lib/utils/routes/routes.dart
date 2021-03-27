import 'package:flutter/material.dart';

class AppRoute {
  static void to(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }
}
