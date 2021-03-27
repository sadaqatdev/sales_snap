import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/account_controller.dart';
import 'package:sales_snap/controllers/sign_up_controller.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class UpdateProfile extends StatefulWidget {
  final String name, email, dobController;
  UpdateProfile({
    this.dobController,
    this.email,
    this.name,
  });
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    emailController.text = widget.email;
    nameController.text = widget.name;
    dobController.text = widget.dobController;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final controller = Get.put(SignUpController());
  final accountCntroller = Get.put(AccountCntroller());
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2;
    final lableStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
        ),
        body: Container(
            width: Get.width,
            height: Get.height,
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Form(
              key: key,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
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
                              nameController.text[0],
                              style: lableStyle.copyWith(fontSize: 24),
                            ),
                            radius: 38,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(' ${emailController.text}'),
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
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          style: style,
                        ),
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
                      Text('Email', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          style: style,
                        ),
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
                      Text('Birth of Date', style: lableStyle),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: dobController,
                          style: style,
                        ),
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
                        child: GetBuilder<AccountCntroller>(builder: (controo) {
                          return Switch(
                            onChanged: (bool value) {
                              controo.updateNotification(value);
                            },
                            value: controo.pushNotification,
                          );
                        }),
                      )
                    ],
                  ),
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
                  // Spacer(
                  //   flex: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return !controller.isLoding.value
                            ? MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    side: BorderSide(color: Colors.blueAccent)),
                                onPressed: () {
                                  controller.updateUser(MUser(
                                    dob: dobController.text,
                                    email: emailController.text,
                                    name: nameController.text,
                                  ));
                                },
                                child: Text(
                                  'Update',
                                ),
                              )
                            : progressBar();
                      }),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  // Spacer(
                  //   flex: 3,
                  // ),
                ],
              ),
            )));
  }
}
