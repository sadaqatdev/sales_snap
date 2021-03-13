import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SendNotification extends GetxController {
  bool isLoading = false;

  TextEditingController titleControlller = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  TextEditingController copunController = TextEditingController();

  List<String> usersId = [];

  SendNotification({this.usersId});

  //Call of the hello function
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'appnotifications',
      options: HttpsCallableOptions(timeout: Duration(seconds: 5)));

  sendNotification() async {
    isLoading = true;
    update();
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'title': titleControlller.text,
          'body': bodyController.text,
          'users': usersId,
          'copundata': copunController.text ?? 'non'
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
