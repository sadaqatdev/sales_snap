import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/controllers/account_controller.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/account/update_profile.dart';

import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

import 'login_signup_tabs.dart';

class AccountPage extends StatelessWidget {
  final AccountCntroller controller = Get.put(AccountCntroller());
  var hintText2 = "Name ";
  var suffixicon = Icon(
    Icons.pending,
    color: Colors.white,
  );
  final storageINfo = GetStorage();
  var prefixIcon = Icon(Icons.person);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2;
    final lableStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: appBar(
          context: context, title: 'Account', height: 100, action: SizedBox()),
      body: SingleChildScrollView(
        child: Container(
            width: Get.width,
            //height: 850,
            color: Color(0xffE5E5E5),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 10,
            ),
            child: GetBuilder<AccountCntroller>(
                init: AccountCntroller(),
                builder: (controller) {
                  if (controller.isLoding) {
                    return progressBar();
                  }
                  MUser user = controller.user;
                  controller.nameControler.text = user.name;
                  controller.email.text = user.email;
                  controller.dob.text = user.dob;
                  controller.gender.text = user.gender;
                  return Form(
                    key: formKey,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        avatatWidget(controller, lableStyle, style),
                        SizedBox(
                          height: 25,
                        ),
                        customTextField(suffixicon, prefixIcon, user.name,
                            controller.nameControler),
                        customTextField(suffixicon, Icon(Icons.email),
                            user.email, controller.email),
                        customTextField(suffixicon, Icon(Icons.date_range),
                            user.dob, controller.dob),
                        customTextField(suffixicon, Icon(Icons.person),
                            user.gender, controller.gender),
                        Container(
                          height: 50,
                          width: Get.width,
                          margin: EdgeInsets.only(top: 12, left: 4, right: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              CircleAvatar(
                                  backgroundColor: AppTheme.customColorThree,
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Text('Notifications'),
                              ),
                              Switch(
                                onChanged: (bool value) {
                                  controller.updateNotification(value);
                                  FocusScope.of(context).unfocus();
                                },
                                value: controller.pushNotification,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text('Your Intrests'),
                        ),
                        Wrap(
                            children: controller.user.intersts
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 8),
                                      child: Text('$e ,'),
                                    ))
                                .toList()),
                        SizedBox(
                          height: 16,
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        CustomButton(
                            lable: 'Save',
                            onPress: () {
                              controller.updateUser();
                            },
                            color: Colors.black,
                            radius: 12),
                        SizedBox(
                          height: 12,
                        ),
                        CustomButton(
                            lable: 'LogOut',
                            onPress: () {
                              storageINfo.remove('isLogin');
                              final auth = FirebaseAuth.instance;
                              auth.signOut();
                              Get.offAll(() => LoginSignUp());
                            },
                            color: AppTheme.customColorThree,
                            radius: 12),
                        SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  );
                })),
      ),
    );
  }

  Widget avatatWidget(
      AccountCntroller controller, TextStyle lableStyle, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            CircleAvatar(
              child: Text(
                controller.user.name[0] ?? '0',
                style: lableStyle.copyWith(fontSize: 24),
              ),
              radius: 38,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              '@ ${controller.user.email}',
              style: style,
            )
          ],
        )
      ],
    );
  }

  Container customTextField(Icon suffixicon, Icon prefixIcon, String hintText2,
      TextEditingController txtController) {
    return Container(
      height: 50,
      width: Get.width,
      margin: EdgeInsets.only(top: 12, left: 4, right: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            obscureText: false,
            controller: txtController,
            decoration: InputDecoration(
              suffixIcon: suffixicon,
              prefixIcon: prefixIcon,
              hintText: hintText2,
              hintStyle: TextStyle(color: Colors.black54),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              fillColor: Colors.transparent,
              filled: true,
            ),
          )),
        ],
      ),
    );
  }
}
