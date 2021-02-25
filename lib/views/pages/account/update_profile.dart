import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/account_controller.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class UpdateProfile extends StatefulWidget {
  final String name, email, password, dobController;
  UpdateProfile({this.dobController, this.email, this.name, this.password});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    emailController.text = widget.email;
    nameController.text = widget.name;
    passController.text = widget.password;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    dobController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
        child: GetBuilder<AccountCntroller>(builder: (controller) {
          if (controller.isLoding) {
            return progressBar();
          }
          return ListView(
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
                          controller.user.name[0],
                          style: lableStyle.copyWith(fontSize: 24),
                        ),
                        radius: 38,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('@ ${controller.user.email}'),
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
                  TextField(
                    controller: nameController,
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
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Text('Terms and Conditions', style: lableStyle),
                  SizedBox(
                    width: 24,
                  ),
                ],
              ),
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
                    onPressed: () {},
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
          );
        }),
      ),
    );
  }
}
