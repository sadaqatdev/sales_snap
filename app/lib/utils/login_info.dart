import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/login_info_controller.dart';

class LoginInfo {
  static String isLogin;
  static String uid;
  final loginInfo = GetStorage();
  void setLoginInfo(User user) {
    loginInfo.write('isLogin', 'yes');
    loginInfo.write('uid', user.uid);
    Get.put(LoginInfoController());
  }
}
