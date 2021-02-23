import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title,
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: Colors.white)),
    toolbarHeight: 70,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
  );
}
