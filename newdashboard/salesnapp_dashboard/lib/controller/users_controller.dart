import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/m_user.dart';
import 'package:sales_snap_dashboard/models/notification_model.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class UserController extends GetxController {
  List<MUser> userList = [];

  List<MUser> searchList = [];

  TextEditingController controller = TextEditingController();

  FirestoreMethods _methods = FirestoreMethods();

  TextEditingController avatarUrlC = TextEditingController();
  TextEditingController cuponCodeC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController productTitle = TextEditingController();
  TextEditingController notificatioTitle = TextEditingController();
  TextEditingController validDate = TextEditingController();
  TextEditingController webUrl = TextEditingController();

  bool isLoading = true;

  List<String> tokensList = [];

  List<String> uidList=[];

  bool viseble=false;

  onInit() {
    super.onInit();
    controller.addListener(getSearchList);
    //_methods.getSavedItems();
    getUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getSearchList() {
    searchList = [];
    print('------------out');
    if (controller.text.isEmpty) {
      print('iiiiiiiiiiiiiiiii');

      searchList = userList;
      update();
    } else {
      print('eeeeeeeeee');
      searchList = userList
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()) ||
              element.email
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()))
          .toList();
      update();
    }
  }

  void getUser() async {
    userList = await _methods.getMuser();

    isLoading = false;
    getSearchList();
    update();
  }

  void selectedUsers({String tokens, bool condition, String uid}) {
    viseble = true;
    update();

    if (condition) {
      tokensList.add(tokens);
      uidList.add(uid);
      if (uidList.length > 0) {
        viseble = true;
      } else {
        viseble = false;
      }

      update();
    } else {
      tokensList.remove(tokens);
      uidList.remove(uid);
      if (uidList.length > 0) {
        viseble = true;
      } else {
        viseble = false;
      }

      update();
    }
  }
 HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'appnotifications',
      options: HttpsCallableOptions(timeout: Duration(seconds: 5)));


  void SendNotification() async{
   NotificationModel model= NotificationModel(
      avatarUrl: avatarUrlC.text,
      cuponCode: cuponCodeC.text,
      desc: descC.text,
      price: priceC.text,
      priceHtmlTag: '[name="og:price:amount"]',
      productTitle: productTitle.text,
      timestamp: Timestamp.now(),
      title: notificatioTitle.text,
      validDate: validDate.text,
      webUrl: webUrl.text,
    );
 isLoading = true;
    
    await _methods.setUserNotification(
        data: model ,
        uidList: uidList);

    await _methods.setNotifications( model);
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'title': notificatioTitle.text,
          'body': descC.text,
          'users': tokensList,
          'copundata': cuponCodeC.text ?? 'non',
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
