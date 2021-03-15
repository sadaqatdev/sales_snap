import 'package:flutter/material.dart';

class ToRoute {
  static void to(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }
}
