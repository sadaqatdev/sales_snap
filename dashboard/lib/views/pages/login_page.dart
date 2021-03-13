import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sales_snap_dashboard/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var width = Get.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginControler>(
          init: LoginControler(),
          builder: (controller) {
            return Container(
              margin: EdgeInsets.only(
                  top: 50, left: width / 3.5, right: width / 3.5, bottom: 50),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(hintText: 'UserName'),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(),
                      TextFormField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(hintText: 'Password'),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      MaterialButton(
                        color: Colors.green,
                        onPressed: () {
                          if (_formKey.currentState.validate())
                            controller.handleSignInEmail();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
