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
                  ucontroller.viseble
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MaterialButton(
                                      color: Colors.green,
                                      onPressed: () {
                                        /// bcontroller.sendNotification();
                                        dialog(context);
                                      },
                                      child: Text('Send Notification Message'),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 16,
                          ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ucontroller.searchList.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                          user: ucontroller.searchList[index],
                          isSelectedFuntction: (value) {
                            ucontroller.selectedUsers(
                                condition: value,
                                tokens: ucontroller.searchList[index].token,
                                uid: ucontroller.searchList[index].uid);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }

  void dialog(
       context) {
    var key = GlobalKey<FormState>();
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Builder(builder: (bcontext) {
            return Container(
              margin:
                  EdgeInsets.only(left: 200, right: 200, top: 150, bottom: 150),
              child: GetBuilder<UserController>(
                   
                  builder: (snapshot) {
                    return Material(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: snapshot.notificatioTitle,
                                decoration: InputDecoration(
                                  hintText: 'Notification Title',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Notification Title';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.descC,
                                decoration: InputDecoration(
                                    hintText: 'Notification Body'),
                                maxLines: 3,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Notification Body';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.cuponCodeC,
                                decoration: InputDecoration(hintText: 'Code'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter code';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.validDate,
                                decoration: InputDecoration(
                                    hintText: 'Validation Date and Message'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter code';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.webUrl,
                                decoration: InputDecoration(
                                    hintText: 'Enter Website Url'),
                                     validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Value';
                                  }
                                  return null;
                                },
                                
                              ),
                               SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.priceC,
                                decoration: InputDecoration(
                                    hintText: 'Enter Price'),
                                      validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Value';
                                  }
                                  return null;
                                },
                                
                              ),
                               SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: snapshot.productTitle,
                                decoration: InputDecoration(
                                    hintText: 'Product Titlte'),
                                      validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Value';
                                  }
                                  return null;
                                },
                                  
                                
                              ),
                               SizedBox(
                                height: 16,
                              ),
                             
                              snapshot.isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            if (key.currentState.validate()) {
                                              snapshot.SendNotification();
                                            }
                                          },
                                          child: Text('Send'),
                                        )
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          });
        });
}}

class UserTile extends StatefulWidget {
  final MUser user;
  final ValueChanged<bool> isSelectedFuntction;
  final Key key;
  UserTile({this.user, this.isSelectedFuntction, this.key}) : super(key: key);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserDetails(
              uid: widget.user.uid,
            );
          }));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value;

                          widget.isSelectedFuntction(value);
                        });
                      }),
                  SizedBox(
                    width: 12,
                  )
                ],
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
                          Text(widget.user.name),
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
                          Text(widget.user.email ?? ''),
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
                          Text(widget.user.location ?? 'non'),
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
                          Text(widget.user.gender),
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
                          Text(widget.user.dob ?? ''),
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
                          Text(widget.user.createdDate?.toDate().toString() ??
                              ''),
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
                  Wrap(
                      children: widget.user.intersts
                          .map((e) => Text('$e ,'))
                          .toList()),
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
