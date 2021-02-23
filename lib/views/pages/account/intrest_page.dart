import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/views/bottom_navigation.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class IntrestPage extends StatefulWidget {
  @override
  _IntrestPageState createState() => _IntrestPageState();
}

class _IntrestPageState extends State<IntrestPage> {
  List<String> _list = [];
  List<bool> _isChecked = [];

  FireStoreMethod _method = FireStoreMethod();
  SignUpController _controller = Get.put(SignUpController());
  @override
  void initState() {
    _list = [
      'Fashion',
      'Electrical & Tech',
      'Home & Garden',
      'Health & Wellness',
      'Beauty',
      'Travel & Accomodation',
    ];
    _isChecked = List<bool>.filled(_list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
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
                  'step 4 of 4',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white),
                ))),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Interests')],
            ),
            Expanded(
              flex: 22,
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked[index] = value;
                      });
                      if (value) {
                        SignUpController.intersts.add(_list[index]);
                      } else {
                        SignUpController.intersts
                            .remove(_list.elementAt(index));
                      }
                      print(SignUpController.intersts);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      _list[index],
                    ),
                    value: _isChecked[index],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Select all that apply')],
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  if (_controller.isLoding.value) {
                    return progressBar();
                  }
                  return MaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.pink),
                        borderRadius: BorderRadius.circular(22)),
                    child: Center(
                      child: Text('Next'),
                    ),
                    onPressed: () {
                      if (SignUpController.intersts.isEmpty) {
                        print(SignUpController.intersts);
                        Get.showSnackbar(GetBar(
                          message: 'Please select at least one interest',
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      }

                      _method
                          .setUser(MUser(
                        dob: SignUpController.dob,
                        email: SignUpController.email,
                        gender: SignUpController.gender,
                        intersts: SignUpController.intersts.toList(),
                        name: SignUpController.name,
                      ))
                          .then((s) {
                        Get.offAll(() => BottomNavBar());
                      });
                    },
                  );
                }),
                SizedBox(
                  width: 24,
                )
              ],
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }

  Widget tile() {
    return SwitchListTile(
      onChanged: (bool value) {},
      value: null,
    );
  }
}
