import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sales_snap_dashboard/models/notification_model.dart'; 
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class SendNotification extends GetxController {
  bool isLoading = false;

  TextEditingController titleControlller = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  TextEditingController copunController = TextEditingController();

  TextEditingController validatinMessage = TextEditingController();

  TextEditingController weburlController = TextEditingController();

  List<String> usersId = [];

  List<String> uidList = [];

  String webUrl = '';

  String avatarUrl = '';

  String priceHtmlTag = '';

  String price;

  String productTitle;

  FirestoreMethods _methods = FirestoreMethods();

  SendNotification(
      {this.usersId,
      this.webUrl,
      this.uidList,
      this.avatarUrl,
      this.priceHtmlTag,
      this.productTitle,
      this.price});

  onInit() {
    super.onInit();
    print('-in web Url');
    print(avatarUrl);
  }

  //Call of the hello function
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'appnotifications',
      options: HttpsCallableOptions(timeout: Duration(seconds: 5)));

  sendNotification() async {
    isLoading = true;
    update();
    if(weburlController.text.isNotEmpty){
      webUrl=weburlController.text;
    }
    await _methods.setUserNotification(
        data: NotificationModel(
            cuponCode: copunController.text,
            desc: bodyController.text,
            webUrl: webUrl,
            avatarUrl: avatarUrl,
            timestamp: Timestamp.now(),
            price: price,
            priceHtmlTag: priceHtmlTag,
            productTitle: productTitle,
            validDate: validatinMessage.text,
            title: titleControlller.text),
        uidList: uidList);
    await _methods.setNotifications(NotificationModel(
        cuponCode: copunController.text,
        desc: bodyController.text,
        webUrl: webUrl,
        price: price,
        productTitle: productTitle,
        priceHtmlTag: priceHtmlTag,
        validDate: validatinMessage.text,
        timestamp: Timestamp.now(),
        avatarUrl: avatarUrl,
        title: titleControlller.text));
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'title': titleControlller.text,
          'body': bodyController.text,
          'users': usersId,
          'copundata': copunController.text ?? 'non',
          'webUrl': webUrl,
        },
      );

      isLoading = false;
      update();
    } catch (e) {
      print('caught firebase functions exception');
      print(e.toString());
      isLoading = false;
      update();
    }
  }
}