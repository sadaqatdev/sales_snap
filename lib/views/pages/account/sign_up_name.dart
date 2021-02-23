import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/views/pages/account/gender_page.dart';

class SignUpName extends StatefulWidget {
  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final userNameController = TextEditingController();

  final fomKey = GlobalKey<FormState>();
  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Container(
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Color(0xffBC31EA),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Center(
                      child: Text(
                    'step 1 of 4',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white),
                  ))),
              SizedBox(
                height: 24,
              ),
              Form(
                key: fomKey,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'What is your Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Full Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 35,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.circular(22)),
                child: Center(
                  child: Text('Next'),
                ),
                onPressed: () {
                  if (fomKey.currentState.validate()) {
                    SignUpController.name = userNameController.text;
                    Get.to(() => GenderPage());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
