import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/views/pages/main_screen.dart';

class LoginControler extends GetxController {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    nameController.text = 'admin@salessnap.com';
    passwordController.text = '1234567';
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  var isloding = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail() async {
    isloding = true;
    update();
    UserCredential result = await _auth
        .signInWithEmailAndPassword(
            email: nameController.text, password: passwordController.text)
        .catchError((onError) {
      Get.showSnackbar(GetBar(
        message: onError.toString(),
        duration: Duration(seconds: 2),
      ));
      print(onError.toString());
    });
    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    if (user != null) {
      Get.to(MainScreen());
      isloding = false;
      update();
      return currentUser;
    } else {
      isloding = false;
      update();
      return null;
    }
  }
}
