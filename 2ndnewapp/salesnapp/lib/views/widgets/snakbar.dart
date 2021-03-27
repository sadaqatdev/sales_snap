import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnak(String title) {
  Get.showSnackbar(GetBar(
    message: title,
    duration: Duration(seconds: 2),
  ));
}

Widget progressBar() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 5,
    ),
  );
}
