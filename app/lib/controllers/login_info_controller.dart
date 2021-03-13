import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/utils/login_info.dart';

class LoginInfoController extends GetxController {
  final loginInfo = GetStorage();

  @override
  onInit() {
    LoginInfo.isLogin = loginInfo.read('isLogin');
    LoginInfo.uid = loginInfo.read('uid');
    super.onInit();
  }
}
