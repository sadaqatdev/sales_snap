import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/repositories/auth_repo.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/login_info.dart';

class SignUpController extends GetxController {
  static String email = '',
      password = '',
      name = '',
      gender = 'male',
      dob = '',
      userLocation = '';
  static Set<String> intersts = {};

  final FireStoreMethod _fireStoreMethod = FireStoreMethod();
String onesignalUserId;
  AuthRepo _authRepo;
  final LoginInfo _loginInfo = LoginInfo();
  var isLoding = false.obs;
  GetStorage storage;
  @override
  void onInit() {
    _authRepo = AuthRepo();
     storage = GetStorage();
     initOnSignal();
    super.onInit();
  }
 void initOnSignal() async {
    await OneSignal.shared.init('4cd671ff-1756-4e7a-8f03-f90a7bace30f');

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.inFocusDisplayType();

   
  }
  void googleLogin() {
    _authRepo.googleSignIn().catchError((err) {
      showBar(err);
    }).then((user) {
      _fireStoreMethod.setUser(MUser(
          email: user.email, name: user.displayName, imageUrl: user.photoURL));
      _loginInfo.setLoginInfo(user);
    });
  }

  void showBar(err) {
    Get.showSnackbar(GetBar(
      message: err.toString(),
      duration: Duration(seconds: 3),
    ));
  }

  void login(loginEmail, loginPassword) {
    _authRepo.handleSignUp(email: email, password: password).catchError((err) {
      print('------print-------');
      showBar(err);
    }).then((user) {
      if (user == null) {
        isLoding(false);
        return;
      }
    });
  }

  void updateUser(user) {
    isLoding(true);
    _fireStoreMethod.updateUser(user).then((value) {
      isLoding(false);
      showBar('Sucessfully Updated');
    }).catchError((e) {
      showBar('Not Updated');
      isLoding(false);
    });
  }

  void setLoginInfo() {
    // _loginInfo.setLoginInfo(user);
    //    _fireStoreMethod
    //         .setUser(MUser(email: loginEmail, name: name, imageUrl: ''));
  }
}
