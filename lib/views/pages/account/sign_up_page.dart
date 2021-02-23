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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12),
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
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailContoller,
                decoration: InputDecoration(hintText: 'Email'),
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
                decoration: InputDecoration(hintText: 'Password'),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(hintText: 'Confirm Password'),
                validator: (value) {
                  return confiemPassword(value);
                },
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    if (controller.isLoding.value == true) {
                      return progressBar();
                    }
                    return MaterialButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(22)),
                      child: Center(
                        child: Text('SignUp'),
                      ),
                      onPressed: () {
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
                              message: error.toString(),
                              duration: Duration(seconds: 3),
                            ));
                          });
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
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(22)),
                color: Colors.redAccent,
                child: Center(
                  child: Text('Google'),
                ),
                onPressed: () {
                  controller.googleLogin();
                },
              ),
              SizedBox(height: 14),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(22)),
                color: Colors.blue,
                child: Center(
                  child: Text('Facebook'),
                ),
                onPressed: () {
                  controller.googleLogin();
                },
              ),
            ],
          ),
        ),
      ),
    );
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
