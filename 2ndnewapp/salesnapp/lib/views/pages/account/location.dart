import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/custom_heading.dart';

import 'intrest_page.dart';

class SignUpLocation extends StatefulWidget {
  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpLocation> {
  final locationController = TextEditingController();

  final fomKey = GlobalKey<FormState>();
  final GetStorage storage = GetStorage();
  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 24, right: 24, top: 70, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeading(
                  progressWidth: 260,
                  steps: 'step 4 of 5',
                  lable: 'Your Postcode'),
              Form(
                key: fomKey,
                child: Container(
                  margin: EdgeInsets.only(top: 12, left: 4, right: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: locationController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: 'Post Code',
                        hintStyle: GoogleFonts.montserrat(fontSize: 14),
                        fillColor: Colors.transparent,
                        contentPadding:
                            EdgeInsets.only(top: 12, bottom: 12, left: 12)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'City Name and Post Code';
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
                  if (fomKey.currentState.validate()) {
                    SignUpController.userLocation = locationController.text;
                    storage.write('location', locationController.text);
                    Get.to(() => IntrestPage());
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
    );
  }
}
