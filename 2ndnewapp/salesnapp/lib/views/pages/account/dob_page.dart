import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/views/pages/account/location.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/custom_heading.dart';

class DobPage extends StatefulWidget {
  @override
  _DobPageState createState() => _DobPageState();
}

class _DobPageState extends State<DobPage> {
  final date = TextEditingController();

  final month = TextEditingController();

  final year = TextEditingController();

  final fomKey = GlobalKey<FormState>();

  final fromKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    date.dispose();
    month.dispose();
    year.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 24, right: 24, top: 70, bottom: 16),
          child: Column(
            children: [
              CustomHeading(
                  progressWidth: 243,
                  steps: 'Step 3/5',
                  lable: 'Please enter your date of birth'),
              SizedBox(
                height: 20,
              ),
              Form(
                key: fromKey,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        controller: date,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'DD',
                        ),
                        onChanged: (val) {
                          if (val.length == 2) {
                            node.nextFocus();
                          }
                        },
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Day';
                          } else if (!value.isNum) {
                            return 'Enter Valid Number';
                          } else if (int.parse(value) > 0 &&
                              int.parse(value) < 32) {
                            return null;
                          } else {
                            return 'Enter valid Month';
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                        controller: month,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'MM',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        maxLength: 2,
                        onChanged: (val) {
                          if (val.length == 2) {
                            node.nextFocus();
                          }
                        },
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Month';
                          } else if (!value.isNum) {
                            return 'Enter Valid Number';
                          } else if (int.parse(value) > 0 &&
                              int.parse(value) < 13) {
                            return null;
                          } else {
                            return 'Enter valid Month';
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                        controller: year,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'YYYY',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        maxLength: 4,
                        validator: (value) {
                          final year = DateTime.now();
                          if (value.isEmpty) {
                            return 'Enter Year';
                          } else if (!value.isNum) {
                            return 'Enter Valid Number';
                          } else if (value.length != 4) {
                            return 'Enter Valid Number';
                          } else if (int.parse(value) > 1950 &&
                              int.parse(value) < year.year) {
                            return null;
                          } else {
                            return 'Enter valid Month';
                          }
                        },
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 150,
              ),
              CustomButton(
                  lable: 'Continue',
                  color: Colors.black,
                  radius: 22,
                  onPress: () {
                    if (fromKey.currentState.validate()) {
                      SignUpController.dob =
                          '${year.text}-${month.text}-${date.text}';
                      Get.to(() => SignUpLocation());
                    } else {
                      Get.showSnackbar(GetBar(
                        message: 'Please Enter Your Data Of Birth',
                        duration: Duration(seconds: 2),
                      ));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
