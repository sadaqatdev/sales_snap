
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_web_picker/imagePiker.dart';
import 'package:sales_snap_dashboard/models/intrest.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class GroupTab extends StatefulWidget {
  @override
  _GroupTabState createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab> {
  final FirestoreMethods methods = FirestoreMethods();

  final formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

   ImagePickerWeb imagePickerWeb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Expanded(
          child: FutureBuilder<List<Intrest>>(
              future: methods.getIntersts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(18),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: snapshot.data[index].avatar == null
                                    ? Icon(Icons.person_outline_rounded)
                                    : Image(
                                        image: NetworkImage(
                                            snapshot.data[index].avatar)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(snapshot.data[index].lable ?? '')
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
            backgroundColor: Colors.green,
            content: Container(
              margin: EdgeInsets.all(22),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(hintText: 'Group Name'),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        // imagePickerWeb = await ImagePickerWeb().getImage();
                      },
                      child: Text('Group Image'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              methods.uploadFile(imagePickerWeb).then((url) {
                                 
                                     methods.createIntersts(Intrest(avatar: url,lable:controller.text )).then((value) {
                                       setState(() {
                                                                                
                                                                              });
                                     });
                                  
                              });
                            }
                          },
                          child: Text('Create'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return CreateGroup();
          // }));
        },
      ),
    );
  }
}