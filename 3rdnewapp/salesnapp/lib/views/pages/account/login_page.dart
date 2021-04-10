import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';

import 'package:sales_snap/repositories/auth_repo.dart';

import 'package:sales_snap/utils/login_info.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/bottom_navigation.dart';
import 'package:sales_snap/views/pages/account/sign_up_name.dart';
import 'package:sales_snap/views/pages/account/sign_with_email.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passworController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final SignUpController _controller = Get.put(SignUpController());
  LoginInfo _loginInfo = LoginInfo();
  final loginInfo = GetStorage();

  AuthRepo _repo = AuthRepo();

  bool show = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passworController.dispose();
    userNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lablesStyle = Theme.of(context).textTheme.headline2;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Obx(() {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 260,
                            width: 38,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(18),
                                    bottomRight: Radius.circular(18))),
                          ),
                          Container(
                            height: 350,
                            width: 275,
                            decoration: BoxDecoration(
                                 
                                // image: DecorationImage(image: AssetImage('assets/spl.png')),
                                borderRadius: BorderRadius.all(Radius.circular(18))),
                                child: Image.asset('assets/spl.png',width: 275,)
                          ),
                          Container(
                            height: 260,
                            width: 38,
                           decoration: BoxDecoration(
                                color: Color(0xff24B4D6),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    bottomLeft: Radius.circular(18))),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 22),
                        child: MaterialButton(
                          padding: EdgeInsets.only(
                              top: 18, bottom: 18, left: 12, right: 12),
                          height: 50,
                          minWidth: 326,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xff1877F2)),
                              borderRadius: BorderRadius.circular(22)),
                          color: Color(0xff1877F2),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Sign In with Email',
                                  style: lablesStyle,
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            AppRoute.to(context, SignWithEmail());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: MaterialButton(
                          elevation: 6,
                          padding: EdgeInsets.only(top: 18, bottom: 18),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xffEA4335)),
                              borderRadius: BorderRadius.circular(22)),
                          color: Color(0xffEA4335),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google.png',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Continue with Google',
                                    style: lablesStyle),
                              ],
                            ),
                          ),
                          onPressed: () {
                            googleLogin();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: MaterialButton(
                          padding: EdgeInsets.only(top: 18, bottom: 18),
                          height: 50,
                          minWidth: 326,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xff1877F2)),
                              borderRadius: BorderRadius.circular(22)),
                          color: Color(0xff1877F2),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/facebook.png',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Continue with Facebook',
                                  style: lablesStyle,
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            facebookLogin();
                          },
                        ),
                      ),
                      SizedBox(height: 14),
                      Text('or'),
                      SizedBox(height: 14),
                      MaterialButton(
                        child: Center(
                          child: Text(
                            'Create account with Email',
                            style: lablesStyle.copyWith(color: Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          AppRoute.to(context, SignUpPage());
                        },
                      ),
                    ],
                  ),
                  _controller.isLoding.value
                      ? Positioned(
                          top: 110,
                          left: Get.width / 2 - 50,
                          child: progressBar(),
                        )
                      : SizedBox()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  String passwordValidate(String value) {
    if (value.isEmpty)
      return 'Empty Password';
    else if (value.length < 7)
      return 'Enter password of lenght greater than 7';
    else
      return null;
  }

  String userNameValidate(String value) {
    if (value.isEmpty)
      return 'Empty UserName';
    else if (!value.contains('@'))
      return 'Enter  @';
    else if (!value.contains('.com'))
      return 'Enter domain .com';
    else if (value.length < 7)
      return 'Enter valid email';
    else
      return null;
  }

  void googleLogin() {
    _controller.isLoding(true);
    _repo.googleSignIn().catchError((err) {
      Get.showSnackbar(GetBar(
        message: 'Error Please Try Again',
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      if (user != null) {
        _loginInfo.setLoginInfo(user);
        SignUpController.email = user.email;
        Get.to(() => SignUpName());
        _controller.isLoding(false);
      } else {
        _controller.isLoding(false);
        Get.showSnackbar(GetBar(
          message: 'Error Try Again',
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  void facebookLogin() {
    _controller.isLoding(true);
    _repo.signUpWithFacebook().catchError((err) {
      _controller.isLoding(false);
      Get.showSnackbar(GetBar(
        message: 'Error Please Try Again',
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      if (user != null) {
        _loginInfo.setLoginInfo(user);
        
        Get.to(() => SignUpName());
        _controller.isLoding(false);
      } else {
        _controller.isLoding(false);
        Get.showSnackbar(GetBar(
          message: 'Error Try Again',
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  void login() {
    if (formKey.currentState.validate()) {
      _controller.isLoding(true);
      _repo
          .handleSignInEmail(
              email: userNameController.text, password: passworController.text)
          .catchError((err) {
        _controller.isLoding(false);
        Get.showSnackbar(GetBar(
          message: 'Error Please Try Again',
          duration: Duration(seconds: 3),
        ));
      }).then((user) {
        if (user != null) {
          _loginInfo.setLoginInfo(user);
          _controller.isLoding(false);
          Get.offAll(() => BottomNavBar());
          print('in then');
        } else {
          _controller.isLoding(false);
          Get.showSnackbar(GetBar(
            message: 'Error Please Try Again',
            duration: Duration(seconds: 3),
          ));
        }
      });
    } else {
      Get.showSnackbar(GetBar(
        message: 'Please Fill All Fields',
        duration: Duration(seconds: 3),
      ));
    }
  }
}
