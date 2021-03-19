import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/views/bottom_navigation.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/custom_heading.dart';
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

  String token = '';
  @override
  void initState() {
    _list = [
      'Sports',
      'Organic',
      'Coffee',
      'Runing  ',
      'Vegan',
      'Sleep',
      'Furity',
      'Meditation',
      'Eat Clean',
    ];
    _isChecked = List<bool>.filled(_list.length, false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 16),
          child: Column(
            children: [
              CustomHeading(
                progressWidth: Get.width - 50,
                steps: 'Step 4/4',
                lable: 'Time to customize your interest',
              ),
              Container(
                height: 800,
                width: 350,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _list.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return buildTile(index);
                    }),
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      _isChecked = List<bool>.filled(_list.length, true);
                      SignUpController.intersts.addAll(_list);
                    });
                  },
                  child: Text('Select all')),
              SizedBox(
                height: 24,
              ),
              Obx(() {
                return _controller.isLoding.value
                    ? progressBar()
                    : CustomButton(
                        lable: 'Continue',
                        color: Colors.black,
                        radius: 22,
                        onPress: () {
                          if (SignUpController.intersts.isEmpty) {
                            print(SignUpController.intersts);

                            Get.showSnackbar(GetBar(
                              message: 'Please select at least one interest',
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            _controller.isLoding(true);
                            _method
                                .setUser(
                              MUser(
                                  dob: SignUpController.dob,
                                  email: SignUpController.email,
                                  gender: SignUpController.gender,
                                  intersts: SignUpController.intersts.toList(),
                                  name: SignUpController.name,
                                  token: token,
                                  createdDate: Timestamp.now()),
                            )
                                .then((s) {
                              _controller.isLoding(false);
                              Get.offAll(() => BottomNavBar());
                            });
                          }
                        });
              }),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTile(int index) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          width: 80,
          height: 80,
          padding: EdgeInsets.all(8),
          child: Center(child: Image.asset('assets/image$index.png')),
        ),
        Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Checkbox(
              onChanged: (bool value) {
                setState(() {
                  _isChecked[index] = value;
                });
                if (value) {
                  SignUpController.intersts.add(_list[index]);
                } else {
                  SignUpController.intersts.remove(_list.elementAt(index));
                }
              },
              value: _isChecked[index],
            ),
            Text(_list[index])
          ],
        )
      ],
    );
  }

  Widget tile() {
    return SwitchListTile(
      onChanged: (bool value) {},
      value: null,
    );
  }
}
