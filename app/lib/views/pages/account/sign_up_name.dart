import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/account/gender_page.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/custom_heading.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeading(
                    progressWidth: 33,
                    steps: 'step 1 of 4',
                    lable: 'Your Name'),
                Form(
                  key: fomKey,
                  child: Container(
                    margin: EdgeInsets.only(top: 12, left: 4, right: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: userNameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: 'What is your Name',
                          fillColor: Colors.transparent,
                          contentPadding:
                              EdgeInsets.only(top: 12, bottom: 12, left: 12)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Full Name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                ),
                CustomButton(
                  lable: 'Continue',
                  color: Colors.black,
                  radius: 22,
                  onPress: () {
                    print('------');
                    if (fomKey.currentState.validate()) {
                      SignUpController.name = userNameController.text;
                      Get.to(() => GenderPage());
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
