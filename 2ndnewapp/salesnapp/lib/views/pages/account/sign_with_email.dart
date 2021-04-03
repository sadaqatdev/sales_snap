import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/repositories/auth_repo.dart';
import 'package:sales_snap/utils/login_info.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

import '../../bottom_navigation.dart';

class SignWithEmail extends StatefulWidget {
  @override
  _SignWithEmailState createState() => _SignWithEmailState();
}

class _SignWithEmailState extends State<SignWithEmail> {
  final TextEditingController passworController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailSend = TextEditingController();
  final AuthRepo _authRepo = AuthRepo();
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

  var suffixicon = Icon(
    Icons.pending,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final lablesStyle = Theme.of(context).textTheme.headline2;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(22),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              Text(
                'Login to App',
                style: lablesStyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 32,
              ),
              customTextField(suffixicon, Icon(Icons.email), 'Email',
                  userNameController, userNameValidate),
              customTextField(
                  IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: show
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                  Icon(Icons.lock),
                  'Password',
                  passworController,
                  passwordValidate),
              SizedBox(height: 70),
              Obx(() {
                if (_controller.isLoding.value == true) {
                  return progressBar();
                }
                return CustomButton(
                    lable: 'Login',
                    onPress: () {
                      login();
                    },
                    color: Colors.black,
                    radius: 18);
              }),
              SizedBox(
                height: 35,
              ),
              MaterialButton(
                child: Center(
                  child: Text(
                    'Reset Password',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  Get.defaultDialog(
                      backgroundColor: Colors.grey,
                      title: 'Enter Email Address',
                      content: customTextField(suffixicon, Icon(Icons.email),
                          'Email', emailSend, userNameValidate),
                      confirm: InkWell(
                          child: Text('Send'),
                          onTap: () async {
                            if (emailSend.text != null) {
                              await _authRepo
                                  .resetPassword(emailSend.text)
                                  .then((msg) {
                                if (msg == 'ok') {
                                  Navigator.pop(context);
                                  Get.defaultDialog(
                                      content: Text(
                                          'Password Reset link is send to your Email address.'));
                                } else {
                                  Get.dialog(Text(msg));
                                }
                              });
                            } else {
                              Get.defaultDialog(
                                  content: Text('Enter Email Address'));
                            }
                          }));
                  //emailSend
                  // if (formKey.currentState.validate()) {
                  //   await _authRepo
                  //       .resetPassword(userNameController.text)
                  //       .then((msg) {
                  //     if (msg == 'ok') {
                  //       Get.defaultDialog(
                  //           content: Text(
                  //               'Password Reset link is send to your Email address.'));
                  //     } else {
                  //       Get.dialog(Text(msg));
                  //     }
                  //   });
                  // } else {
                  //   Get.showSnackbar(GetBar(
                  //     message:
                  //         'Enter only Email, we send password reset link to your Email address',
                  //     duration: Duration(seconds: 3),
                  //   ));
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container customTextField(Widget suffixicon, Icon prefixIcon,
      String hintText2, TextEditingController txtController, validator) {
    return Container(
      //height: 50,
      width: Get.width,
      margin: EdgeInsets.only(top: 12, left: 4, right: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            obscureText: false,
            controller: txtController,
            validator: validator,
            decoration: InputDecoration(
              suffixIcon: suffixicon,
              prefixIcon: prefixIcon,
              hintText: hintText2,
              hintStyle: TextStyle(color: Colors.black54),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              fillColor: Colors.transparent,
              filled: true,
            ),
          )),
        ],
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
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty)
      return 'Empty UserName';
    else if (!value.contains('@'))
      return 'Enter  @';
    else if (!value.contains('.com'))
      return 'Enter domain .com';
    else if (value.length < 7)
      return 'Enter valid email';
    else if (emailValid)
      return null;
    else
      return null;
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
