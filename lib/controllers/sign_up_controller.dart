import 'package:get/get.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/repositories/auth_repo.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/login_info.dart';

class SignUpController extends GetxController {
  static String email, password, name, gender = 'male', dob;
  static Set<String> intersts = {};

  final FireStoreMethod _fireStoreMethod = FireStoreMethod();

  AuthRepo _authRepo;
  final LoginInfo _loginInfo = LoginInfo();
  var isLoding = false.obs;
  @override
  void onInit() {
    _authRepo = AuthRepo();
    super.onInit();
  }

  void googleLogin() {
    _authRepo.googleSignIn().catchError((err) {
      Get.showSnackbar(GetBar(
        message: err.toString(),
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      _fireStoreMethod.setUser(MUser(
          email: user.email, name: user.displayName, imageUrl: user.photoURL));
      _loginInfo.setLoginInfo(user);
    });
  }

  void login(loginEmail, loginPassword) {
    _authRepo.handleSignUp(email: email, password: password).catchError((err) {
      print('------print-------');
      // Get.showSnackbar(GetBar(
      //   message: err.toString(),
      //   duration: Duration(seconds: 3),
      // ));
    }).then((user) {
      if (user == null) {
        isLoding(false);
        return;
      }
    });
  }

  void setLoginInfo() {
    // _loginInfo.setLoginInfo(user);
    //    _fireStoreMethod
    //         .setUser(MUser(email: loginEmail, name: name, imageUrl: ''));
  }
}
