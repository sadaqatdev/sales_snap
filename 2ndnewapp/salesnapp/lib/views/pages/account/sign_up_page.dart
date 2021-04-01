import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/repositories/auth_repo.dart';
import 'package:sales_snap/utils/login_info.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

import 'sign_up_name.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController passworController = TextEditingController();

  //final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailContoller = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final SignUpController controller = Get.put(SignUpController());

  final AuthRepo _repo = AuthRepo();

  final _formKey = GlobalKey<FormState>();

  final storage = GetStorage();

  LoginInfo _loginInfo = LoginInfo();
  bool show = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passworController.dispose();

    emailContoller.dispose();
    confirmPassword.dispose();

    super.dispose();
  }
//  validator: (value) {
//                         bool emailValid = RegExp(
//                                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                 .hasMatch(emailContoller.text);
//                         if(emailValid){
//                           return null;
//                         }else{
//                           return 'Enter valid Email Address';
//                         }

//                     },
//
//
  String emailValidate(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailContoller.text);
    if (emailValid) {
      return null;
    } else {
      return 'Enter valid Email Address';
    }
  }

  var suffixicon = Icon(
    Icons.pending,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final lablesStyle = Theme.of(context).textTheme.headline2;
    final headingStyle = Theme.of(context).textTheme.headline2;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 25),
            width: Get.width,
             
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Sign Up ',
                    style: lablesStyle.copyWith(color: Color(0xff24B4D6)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Create Account',
                    style: headingStyle.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  customTextField(suffixicon, Icon(Icons.email), 'Email',
                      emailContoller, emailValidate),
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
                      passwordValid),
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
                      'Confirm Password',
                      confirmPassword,
                      confiemPassword),
                  SizedBox(
                    height: 70,
                  ),
                  Obx(() {
                    if (controller.isLoding.value == true) {
                      return progressBar();
                    }
                    return  CustomButton(lable: 'Continue', onPress: (){
                        if (_formKey.currentState.validate()) {
                          controller.isLoding(true);
                          _repo
                              .handleSignUp(
                                  email: emailContoller.text,
                                  password: passworController.text)
                              .then((user) {
                            controller.isLoding(false);
                            SignUpController.email = emailContoller.text;
                            Get.to(() => SignUpName());
                          }).catchError((error) {
                            controller.isLoding(false);
                            Get.showSnackbar(GetBar(
                              message:
                                  'The email address is already in use by another account',
                              duration: Duration(seconds: 3),
                            ));
                          });
                        } else {
                          controller.isLoding(false);
                          Get.showSnackbar(GetBar(
                            message: 'Enter Valid Email Address',
                            duration: Duration(seconds: 3),
                          ));
                        }
                    }, color: Colors.black, radius: 22);
                  }),
                  SizedBox(height: 14),
                ],
              ),
            ),
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

  void facebookLogin() {
    controller.isLoding(true);
    _repo.signUpWithFacebook().catchError((err) {
      controller.isLoding(false);
      Get.showSnackbar(GetBar(
        message: 'Error Please Try Again',
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      if (user != null) {
        _loginInfo.setLoginInfo(user);
        SignUpController.email = user.email;
        Get.to(() => SignUpName());
        controller.isLoding(false);
      } else {
        controller.isLoding(false);
        Get.showSnackbar(GetBar(
          message: 'Error Try Again',
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  void googleLogin() {
    controller.isLoding(true);
    _repo.googleSignIn().catchError((err) {
      controller.isLoding(false);
      Get.showSnackbar(GetBar(
        message: 'Error Please Try Again',
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      if (user != null) {
        _loginInfo.setLoginInfo(user);
        SignUpController.email = user.email;
        Get.to(() => SignUpName());
        controller.isLoding(false);
      } else {
        controller.isLoding(false);
        Get.showSnackbar(GetBar(
          message: 'Error Try Again',
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  String userNameValid(String value) {
    if (value.isEmpty) {
      return 'Please Full Name';
    }
    return null;
  }

  String contactValid(String value) {
    if (value.isEmpty)
      return 'Please Contact Number';
    else if (value.length < 11) return 'Please Enter Valid Number';
    return null;
  }

  String passwordValid(String value) {
    if (value.isEmpty)
      return 'Please Password';
    else if (value.length < 7) return 'Please Enter Password greater than 7';
    return null;
  }

  String confiemPassword(String value) {
    if (value.isEmpty)
      return 'Please Title';
    else if (value.length < 7)
      return 'Please Enter Password greater than 7';
    else if (value != passworController.text) return 'Password Not Match';
    return null;
  }
}
