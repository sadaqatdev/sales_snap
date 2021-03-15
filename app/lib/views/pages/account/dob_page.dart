import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/views/pages/account/intrest_page.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
            child: Column(
              children: [
                CustomHeading(
                    progressWidth: 243,
                    steps: 'Step 3/4',
                    lable: 'Your Birthday'),
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
                          keyboardType: TextInputType.datetime,
                          maxLength: 2,
                          controller: date,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'DD',
                          ),
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Day';
                            }
                            return null;
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
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'MM',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          maxLength: 2,
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Month';
                            }
                            return null;
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
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'YYYY',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          maxLength: 4,
                          onEditingComplete: () {
                            node.unfocus();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Year';
                            }
                            return null;
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
                            '${date.text}-${month.text}-${year.text}';
                        Get.to(() => IntrestPage());
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
      ),
    );
  }
}
