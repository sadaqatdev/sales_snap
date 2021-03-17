import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';

import 'package:sales_snap/repositories/auth_repo.dart';

import 'package:sales_snap/utils/login_info.dart';
import 'package:sales_snap/views/bottom_navigation.dart';
import 'package:sales_snap/views/pages/account/sign_up_name.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passworController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final AuthRepo _authRepo = AuthRepo();
  final formKey = GlobalKey<FormState>();
  final SignUpController _controller = Get.put(SignUpController());
  LoginInfo _loginInfo = LoginInfo();
  final loginInfo = GetStorage();

  AuthRepo _repo = AuthRepo();

  bool show = false;

  @override
  void initState() {
    userNameController.text = 'sadaqat@gm.com';
    passworController.text = '1234567';
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

    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Form(
          key: formKey,
          child: Obx(() {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Login To App',
                      style: lablesStyle.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(hintText: 'User Name'),
                      validator: (value) {
                        return userNameValidate(value);
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: passworController,
                      obscureText: show,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            icon: show
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                      validator: (value) {
                        return passwordValidate(value);
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.pink),
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                            child: Text(
                              'Login',
                              style: lablesStyle.copyWith(color: Colors.black),
                            ),
                          ),
                          onPressed: () {
                            login();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    MaterialButton(
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
                            Text('Continue with Google', style: lablesStyle),
                          ],
                        ),
                      ),
                      onPressed: () {
                        googleLogin();
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    MaterialButton(
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
                      onPressed: () {},
                    ),
                    SizedBox(height: 14),
                    Text('or'),
                    SizedBox(height: 14),
                    MaterialButton(
                      child: Center(
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () async {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(userNameController.text);
                        if (userNameController.text.isNotEmpty && emailValid) {
                          await _authRepo
                              .resetPassword(userNameController.text)
                              .then((msg) {
                            if (msg == 'ok') {
                              Get.defaultDialog(
                                  content: Text(
                                      'Password Reset link is send to your Email address.'));
                            } else {
                              Get.dialog(Text(msg));
                            }
                          });
                        } else {
                          Get.showSnackbar(GetBar(
                            message:
                                'Enter only Email, we send wassword link to your Email address',
                            duration: Duration(seconds: 3),
                          ));
                        }
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
        message: err.toString(),
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      _loginInfo.setLoginInfo(user);
      SignUpController.email = user.email;
      Get.to(() => SignUpName());
      _controller.isLoding(false);
    });
  }

  void facebookLogin() {
    _controller.isLoding(true);
    _repo.signUpWithFacebook().catchError((err) {
      Get.showSnackbar(GetBar(
        message: err.toString(),
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      _loginInfo.setLoginInfo(user);
      SignUpController.email = user.email;
      Get.to(() => SignUpName());
      _controller.isLoding(false);
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
          message: err.toString(),
          duration: Duration(seconds: 3),
        ));
      }).then((user) {
        _loginInfo.setLoginInfo(user);
        _controller.isLoding(false);
        Get.offAll(() => BottomNavBar());
        print('in then');
      });
    } else {
      Get.showSnackbar(GetBar(
        message: 'Please Fill All Fields',
        duration: Duration(seconds: 3),
      ));
    }
  }
}
