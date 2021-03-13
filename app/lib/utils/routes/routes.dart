import 'package:flutter/material.dart';

class Routes {
  void to(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }
}
