import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sales_snap_dashboard/models/notification_model.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class SendNotification extends GetxController {
  bool isLoading = false;

  TextEditingController titleControlller = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  TextEditingController copunController = TextEditingController();

  List<String> usersId = [];

  List<String> uidList = [];

  String webUrl = '';

  FirestoreMethods _methods = FirestoreMethods();

  SendNotification({this.usersId, this.webUrl, this.uidList});

  //Call of the hello function
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'appnotifications',
      options: HttpsCallableOptions(timeout: Duration(seconds: 5)));

  sendNotification() async {
    isLoading = true;
    update();
    await _methods.setUserNotification(
        data: NotificationModel(
            cuponCode: copunController.text,
            desc: bodyController.text,
            title: titleControlller.text),
        uidList: uidList);
    await _methods.setNotifications(NotificationModel(
        cuponCode: copunController.text,
        desc: bodyController.text,
        title: titleControlller.text));
    try {
      print('---------------------------');
      print(usersId.length);
      usersId.forEach((element) {
        print('============================');
        print(element);
      });
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'title': titleControlller.text,
          'body': bodyController.text,
          'users': usersId,
          'copundata': copunController.text ?? 'non',
          'webUrl': webUrl,
        },
      );

      // Get.showSnackbar(GetBar(
      //   message: 'Sucessfully Send Notification',
      //   duration: Duration(seconds: 3),
      // ));

      isLoading = false;
      update();
    } catch (e) {
      print('caught firebase functions exception');
      // Get.showSnackbar(GetBar(
      //   message: 'Error in Sending Notification',
      //   duration: Duration(seconds: 3),
      // ));
      isLoading = false;
      update();
    }
  }
}
