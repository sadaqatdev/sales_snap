import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/account_controller.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'package:sales_snap/views/pages/account/update_profile.dart';

import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class AccountPage extends StatelessWidget {
  final AccountCntroller _accountCntroller = Get.put(AccountCntroller());
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2;
    final lableStyle = Theme.of(context).textTheme.bodyText1;
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Scaffold(
              appBar: appBar(
                  context: context,
                  title: 'Account',
                  height: 100,
                  action: SizedBox()),
              body: Container(
                color: Color(0xffE5E5E5),
                width: Get.width,
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 10,
                ),
                child: GetBuilder<AccountCntroller>(builder: (controller) {
                  if (_accountCntroller.isLoding) {
                    return progressBar();
                  }
                  var hintText2 = "Name ";
                  var suffixicon = Icon(Icons.pending);
                  var prefixIcon = Icon(Icons.person);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      customTextField(suffixicon, prefixIcon, hintText2),
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
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
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
                            Get.to(() => UpdateProfile(
                                  dobController: controller.user.dob,
                                  email: controller.user.email,
                                  name: controller.user.name,
                                ));
                          },
                          color: Colors.black,
                          radius: 12),
                      SizedBox(
                        height: 12,
                      ),
                      CustomButton(
                          lable: 'LogOut',
                          onPress: () {
                            Get.to(() => UpdateProfile(
                                  dobController: controller.user.dob,
                                  email: controller.user.email,
                                  name: controller.user.name,
                                ));
                          },
                          color: AppTheme.customColorThree,
                          radius: 12),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  );
                }),
              ),
            ),
            Positioned(
              top: 120,
              left: 110,
              child: avatatWidget(_accountCntroller, lableStyle, style),
            )
          ],
        ),
      ),
    );
  }

  Row avatatWidget(
      AccountCntroller controller, TextStyle lableStyle, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            CircleAvatar(
              child: Text(
                controller.user.name[0],
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

  Container customTextField(
      Icon suffixicon, Icon prefixIcon, String hintText2) {
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
