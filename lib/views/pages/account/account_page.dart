import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/account_controller.dart';
import 'package:sales_snap/views/pages/account/update_profile.dart';

import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class AccountPage extends StatelessWidget {
  final AccountCntroller _accountCntroller = Get.put(AccountCntroller());
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2;
    final lableStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: appBar(context, 'Profile'),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 10,
          ),
          child: GetBuilder<AccountCntroller>(builder: (controller) {
            if (_accountCntroller.isLoding) {
              return progressBar();
            }
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              elevation: 6,
              shadowColor: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Row(
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
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text('Name', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Text(controller.user.name, style: style)
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text('Email', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        controller.user.email,
                        style: style,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text('Gender', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        controller.user.gender,
                        style: style,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text('Password', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        '**********',
                        style: style,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text('Birth Date', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        controller.user.dob,
                        style: style,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Text('Push Notification', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                        height: 16,
                        child: Switch(
                          onChanged: (bool value) {
                            controller.updateNotification(value);
                          },
                          value: controller.pushNotification,
                        ),
                      )
                    ],
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
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Text('$e ,'),
                              ))
                          .toList()),
                  SizedBox(
                    height: 16,
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 12,
                  //     ),
                  //     Text('Terms and Conditions', style: lableStyle),
                  //     SizedBox(
                  //       width: 24,
                  //     ),
                  //   ],
                  // ),
                  Spacer(
                    flex: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                            side: BorderSide(color: Colors.blueAccent)),
                        onPressed: () {
                          Get.to(() => UpdateProfile(
                                dobController: controller.user.dob,
                                email: controller.user.email,
                                name: controller.user.name,
                              ));
                        },
                        child: Text(
                          'Update',
                        ),
                      ),
                      Spacer(),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                            side: BorderSide(color: Colors.blueAccent)),
                        onPressed: () {},
                        child: Text('Logout'),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
