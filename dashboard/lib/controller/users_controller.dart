import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/m_user.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class UserController extends GetxController {
  List<MUser> userList = [];

  List<MUser> searchList = [];

  TextEditingController controller = TextEditingController();

  FirestoreMethods _methods = FirestoreMethods();

  bool isLoading = true;

  onInit() {
    super.onInit();
    controller.addListener(getSearchList);
    //_methods.getSavedItems();
    getUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } 

  void getSearchList() {
    searchList = [];
    print('------------out');
    if (controller.text.isEmpty) {
      print('iiiiiiiiiiiiiiiii');

      searchList = userList;
      update();
    } else {
      print('eeeeeeeeee');
      searchList = userList
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()) ||
              element.email
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()))
          .toList();
      update();
    }
  }

  void getUser() async {
    userList = await _methods.getMuser();

    isLoading = false;
    getSearchList();
    update();
  }
}
