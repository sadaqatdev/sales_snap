import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/views/pages/account/intrest_page.dart';

class DobPage extends StatefulWidget {
  @override
  _DobPageState createState() => _DobPageState();
}

class _DobPageState extends State<DobPage> {
  final userNameController = TextEditingController();

  final fomKey = GlobalKey<FormState>();
  final sacfoldKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: sacfoldKey,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 16,
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
                      'step 3 of 4',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white),
                    ))),
                SizedBox(
                  height: 20,
                ),
                Text('Please tell us your date of birth'),
                SizedBox(
                  height: 20,
                ),
                CalendarDatePicker(
                  firstDate: DateTime(1930, 9, 7, 17, 30),
                  initialDate: selectedDate,
                  lastDate: DateTime.now(),
                  currentDate: selectedDate,
                  onDateChanged: (DateTime value) {
                    SignUpController.dob = value.toString().substring(0, 11);
                    selectedDate = value;
                    setState(() {});
                  },
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
                    if (SignUpController.dob?.isEmpty ?? true) {
                      Get.showSnackbar(GetBar(
                        message: 'Please Select your Bate of Birth',
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }
                    Get.to(() => IntrestPage());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
