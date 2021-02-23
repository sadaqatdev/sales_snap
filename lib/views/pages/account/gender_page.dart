import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/views/pages/account/dob_page.dart';

enum GenderValue { male, female, notToSay }

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  GenderValue _character = GenderValue.male;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                      'step 2 of 4',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white),
                    ))),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Are You')],
                ),
                ListTile(
                  title: const Text('Male'),
                  leading: Radio(
                    value: GenderValue.male,
                    groupValue: _character,
                    onChanged: (GenderValue value) {
                      setState(() {
                        SignUpController.gender =
                            value.toString().split('.')[1];
                        _character = value;
                        print(value);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio(
                    value: GenderValue.female,
                    groupValue: _character,
                    onChanged: (GenderValue value) {
                      setState(() {
                        SignUpController.gender =
                            value.toString().split('.')[1];
                        _character = value;
                        print(value);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                ListTile(
                  title: const Text('Prefer not to say'),
                  leading: Radio(
                    value: GenderValue.notToSay,
                    groupValue: _character,
                    onChanged: (GenderValue value) {
                      setState(() {
                        SignUpController.gender =
                            value.toString().split('.')[1];
                        _character = value;
                        print(value.toString().split('.')[1]);
                      });
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
                    Get.to(() => DobPage());
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
