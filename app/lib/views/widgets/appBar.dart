import 'package:flutter/material.dart';

AppBar appBar(
    {BuildContext context,
    String title,
    Widget leading,
    Widget action,
    double height}) {
  return AppBar(
    leading: leading,
    actions: [action],
    title: Text(title,
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: Colors.white)),
    toolbarHeight: height,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
  );
}
