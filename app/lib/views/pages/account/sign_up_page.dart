import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/repositories/auth_repo.dart';
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

  final loginInfo = GetStorage();

  bool show = false;
  @override
  void initState() {
    emailContoller.text = 'sa@gm.com';
    passworController.text = '1234567';
    confirmPassword.text = '1234567';
    super.initState();
  }

  @override
  void dispose() {
    passworController.dispose();

    emailContoller.dispose();
    confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lablesStyle = Theme.of(context).textTheme.headline2;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        width: Get.width,
        height: Get.height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Sign Up ',
                style: lablesStyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailContoller,
                decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.only(top: 14, bottom: 14, left: 8)),
                validator: (value) {
                  return emailValid(value);
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passworController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: show,
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
                  return passwordValid(value);
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: confirmPassword,
                obscureText: show,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
                  return confiemPassword(value);
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    if (controller.isLoding.value == true) {
                      return progressBar();
                    }
                    return MaterialButton(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 12, left: 16, right: 16),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(22)),
                      child: Center(
                        child: Text(
                          'SignUp',
                          style: lablesStyle.copyWith(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailContoller.text);
                        if (_formKey.currentState.validate() && emailValid) {
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
                      },
                    );
                  })
                ],
              ),
              SizedBox(height: 14),
              Text('or'),
              SizedBox(height: 14),
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
                  // googleLogin();
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
                onPressed: () {
                  // googleLogin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void googleLogin() {
    controller.isLoding(true);
    _repo.googleSignIn().catchError((err) {
      Get.showSnackbar(GetBar(
        message: err.toString(),
        duration: Duration(seconds: 3),
      ));
    }).then((user) {
      Navigator.pop(context);
      controller.isLoding(true);
    });
  }

  String userNameValid(String value) {
    if (value.isEmpty) {
      return 'Please Full Name';
    }
    return null;
  }

  String emailValid(String value) {
    if (value.isEmpty)
      return 'Please Email';
    else if (!value.contains('@'))
      return 'Please Enter @';
    else if (!value.contains('.com'))
      return 'Please Enter .com';
    else if (value.length < 7) return 'Enter Valid Email';
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
