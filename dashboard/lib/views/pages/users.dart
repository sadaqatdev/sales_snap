import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/users_controller.dart';
import 'package:sales_snap_dashboard/models/m_user.dart';
import 'package:sales_snap_dashboard/views/pages/user_details.dart';
import 'package:sales_snap_dashboard/views/widgets/search_widget.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.height,
        height: Get.width,
        child: GetBuilder<UserController>(
            init: UserController(),
            builder: (ucontroller) {
              return Column(
                children: [
                  SearchWidget(
                    controller: ucontroller.controller,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ucontroller.searchList.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                          user: ucontroller.searchList[index],
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}

class UserTile extends StatelessWidget {
  final MUser user;
  const UserTile({Key key, this.user}) : super(key: key);
  static const intersts = ['sdsd', 'asdad', 'asdad', 'asdad'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserDetails(
              uid: user.uid,
            );
          }));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Name'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(user.name),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Email'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(user.email),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Location'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(user.location??'non'),
                        ],
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Gender'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(user.gender),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Dob'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(user.dob),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Time Of Download'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(user.createdDate?.toDate().toString() ?? ''),
                        ],
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Text('interests'),
                  SizedBox(
                    width: 12,
                  ),
                  Wrap(children: intersts.map((e) => Text('$e ,')).toList()),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
