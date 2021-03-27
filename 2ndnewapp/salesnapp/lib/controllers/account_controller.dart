import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'home_controller.dart';

class AccountCntroller extends GetxController {
  MUser user;
  bool isLoding = false;
  FireStoreMethod _method = FireStoreMethod();
  TextEditingController nameControler = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();

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

  void updateUser() {
    isLoding = true;
    _method
        .updateUser(
            MUser(dob: dob.text, email: gender.text, name: nameControler.text))
        .then((value) {
      isLoding = true;
      showBar('Sucessfully Updated');
    }).catchError((e) {
      showBar('Not Updated');
      isLoding = true;
    });
  }

  void showBar(err) {
    Get.showSnackbar(GetBar(
      message: err.toString(),
      duration: Duration(seconds: 3),
    ));
  }

  void updateNotification(bool value) {
    pushNotification = value;
    onClickEnable(value);

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
