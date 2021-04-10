import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/models/intrest.dart';
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
   
  List<bool> _isChecked = [];

  FireStoreMethod _method = FireStoreMethod();
  SignUpController _controller = Get.put(SignUpController());
  double numb;
  String token = '';
   GetStorage storage;

  bool first=true;
  @override
  void initState() {
    
    
    if(Platform.isIOS){
      numb=225;
    }else{
      numb=220;
    }
    storage=GetStorage();
    getPermission();
    super.initState();
  }

  void getPermission()async{
     OSPermissionSubscriptionState status =
        await OneSignal.shared.getPermissionSubscriptionState();
   
    token = status.subscriptionStatus.userId;

    storage.write('id', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: Get.width,
        padding: EdgeInsets.only(left: 24, right: 24, top: 40, ),
        child: Column(
          children: [
            CustomHeading(
              progressWidth: Get.width - 50,
              steps: 'Step 5/5',
              lable: 'Time to customize your interests',
            ),
            FutureBuilder<List<Intrest>>(
              future: _method.getIntersts(),
              builder: (context, snapshot) {
                  if(snapshot.hasData){
                    if(first){
                      _isChecked = List<bool>.filled(snapshot.data.length, false);
                      first=false;
                    }
                  
                
                return Expanded(
                 // height: (numb * snapshot.data .length) / 2,
                  // width: 350,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data .length,
                      itemBuilder: (BuildContext ctx, index,) {
                        return buildTile(index,snapshot.data);
                      }),
                );
                }else{
                    return Center(child:CircularProgressIndicator());
                  }
              }
            ),
            // SizedBox(
            //   height: 24,
            // ),
            // // InkWell(
            // //     onTap: () {
            // //       setState(() {
            // //         _isChecked = List<bool>.filled(_list.length, true);
            // //         SignUpController.intersts.addAll(_list);
            // //       });
            // //     },
            // //     child: Text('Select all')),
            // SizedBox(
            //   height: 24,
            // ),
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
                                location: SignUpController.userLocation,
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
              height: 28,
            )
          ],
        ),
      ),
    );
  }

  Widget buildTile(int index,List<Intrest> data) {
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
          padding: EdgeInsets.only(top: 9,),
          child: Center(child: Image.network(data[index].avatar)),
        ),
        SizedBox(height: 8,),
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
                  SignUpController.intersts.add(data[index].lable);
                } else {
                  SignUpController.intersts.remove(data[index].lable);
                }
              },
              value: _isChecked[index],
            ),

            Expanded(child: Text(data[index].lable))
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
