import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class AccountCntroller extends GetxController {
  MUser user;
  bool isLoding = false;
  FireStoreMethod _method = FireStoreMethod();
  bool pushNotification;
  final pref = GetStorage();

  @override
  void onInit() {
    String val = pref.read('notificationEnable');
    pushNotification = val?.contains('yes') ?? false;
    getUser();
    super.onInit();
  }

  void getUser() async {
    isLoding = true;
    user = await _method.getMuser();

    isLoding = false;
    update();
  }

  void setMUser(MUser user) async {
    isLoding = true;

    await _method.setUser(user);
    isLoding = false;
    update();
  }

  void updateNotification(bool value) {
    pushNotification = value;
    if (value) {
      pref.write('notificationEnable', 'yes');
      print('---------');
    } else {
      print('==============');
      pref.write('notificationEnable', 'no');
    }
    update();
  }
}
