import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';

import 'package:sales_snap/repositories/auth_repo.dart';

import 'package:sales_snap/utils/login_info.dart';
import 'package:sales_snap/views/bottom_navigation.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passworController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final SignUpController _controller = Get.put(SignUpController());
  final AuthRepo _authRepo = AuthRepo();
  final formKey = GlobalKey<FormState>();

  LoginInfo _loginInfo = LoginInfo();
  final loginInfo = GetStorage();

  AuthRepo _repo = AuthRepo();

  @override
  void initState() {
    userNameController.text = 'sa@gm.com';
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
    final lablesStyle = Theme.of(context).textTheme.headline1;

    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: formKey,
          child: Obx(() {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login To App',
                      style: lablesStyle,
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
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(hintText: 'Password'),
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
                            child: Text('Login'),
                          ),
                          onPressed: () {
                            login();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(22)),
                      color: Colors.redAccent,
                      child: Center(
                        child: Text('Google'),
                      ),
                      onPressed: () {
                        googleLogin();
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(22)),
                      color: Colors.blue,
                      child: Center(
                        child: Text('Facebook'),
                      ),
                      onPressed: () {
                        googleLogin();
                      },
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
                        if (userNameController.text.isNotEmpty) {
                          await _authRepo
                              .resetPassword(userNameController.text)
                              .then((msg) {
                            if (msg == 'ok') {
                              Get.dialog(Text(
                                  'Reset Link is Sent to Your Email Address'));
                            } else {
                              Get.dialog(Text(msg));
                            }
                          });
                        } else {
                          Get.showSnackbar(GetBar(
                            message: 'Email is Empty',
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
      Navigator.pop(context);
      _controller.isLoding(true);
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
