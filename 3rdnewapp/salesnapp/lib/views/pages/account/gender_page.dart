import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/account/dob_page.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/custom_heading.dart';

enum GenderValue { male, female, notToSay }

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {

  bool maleSelected = false;

  bool femaleSelected = false;

  bool notToSay = false;

  @override
  Widget build(BuildContext context) {
    final lableStyel = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 70, bottom: 16),
         
        child: Column(
          children: [
            CustomHeading(
                progressWidth: 168,
                steps: 'Step 2 of 4',
                lable: 'Which one are you?'),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      maleSelected = true;
                      femaleSelected = false;
                      notToSay=false;
                      SignUpController.gender = 'male';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                        color: maleSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: 130,
                    height: 180,
                    padding: EdgeInsets.only(top: 44, left: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor:
                              maleSelected ? Colors.white : Colors.black,
                          child: maleSelected
                              ? Image.asset('assets/maleblack.png')
                              : Image.asset('assets/male.png'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Male',
                          style: maleSelected
                              ? lableStyel.copyWith(color: Colors.white)
                              : lableStyel.copyWith(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      maleSelected = false;
                      femaleSelected = true;
                      notToSay=false;
                      SignUpController.gender = 'female';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                        color: femaleSelected
                            ? AppTheme.customColorThree
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: 130,
                    height: 180,
                    padding: EdgeInsets.only(top: 44, left: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: femaleSelected
                              ? Colors.white
                              : AppTheme.customColorThree,
                          child: femaleSelected
                              ? Image.asset('assets/female_color.png')
                              : Image.asset('assets/female.png'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Female',
                          style: femaleSelected
                              ? lableStyel.copyWith(color: Colors.white)
                              : lableStyel,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(flex: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        SignUpController.gender = 'Not To Say';
                        maleSelected = false;
                        femaleSelected = false;
                        notToSay = true;
                      });
                      print(SignUpController.gender);
                    },
                    child: Container(
                        height: 40,
                        padding: EdgeInsets.all(8),
                      decoration: notToSay?  BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)):BoxDecoration(),
                        child: Center(
                            child: const Text('Prefer not to say')))),
              ],
            ),
            Spacer(),
            CustomButton(
                lable: 'Continue',
                color: Colors.black,
                radius: 22,
                onPress: () {
                  if (femaleSelected || maleSelected || notToSay) {
                    Get.to(() => DobPage());
                  } else {
                    Get.showSnackbar(GetBar(
                      message: 'Please Select At Least One Option',
                      duration: Duration(seconds: 3),
                    ));
                  }
                }),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
