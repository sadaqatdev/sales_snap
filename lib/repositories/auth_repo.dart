import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class AuthRepo {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreMethod _fireStoreMethod = FireStoreMethod();

  Future<User> handleSignInEmail({String email, String password}) async {
    UserCredential result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((onError) {
      print(onError.toString());
    });
    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');
    if (user != null) {
      return currentUser;
    } else {
      return null;
    }
  }

  Future<User> handleSignUp({String email, String password}) async {
    UserCredential result = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((err) {
      Get.showSnackbar(GetBar(
        message: err.toString(),
        duration: Duration(seconds: 3),
      ));
    });

    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  Future<String> resetPassword(String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((err) {
      Get.showSnackbar(GetBar(
        message: err.toString(),
      ));
      return err.toString();
    });
    return 'ok';
  }

  Future<User> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount _signInAccount =
          await _googleSignIn.signIn().catchError((e) {
        Get.showSnackbar(GetBar(
          message: e.toString(),
          duration: Duration(seconds: 3),
        ));
      });
      GoogleSignInAuthentication _signInAuthentication =
          await _signInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: _signInAuthentication.accessToken,
          idToken: _signInAuthentication.idToken);

      final UserCredential authResult =
          await _auth.signInWithCredential(credential).catchError((e) {
        Get.showSnackbar(GetBar(
          message: e.toString(),
          duration: Duration(seconds: 3),
        ));
      });
      final User user = authResult.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: e.toString(),
        duration: Duration(seconds: 3),
      ));
      return null;
    }
  }
}
