import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';

import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class SaveController extends GetxController {
  String uid;
  SaveController({this.uid});
  List<SaveListModel> saveItemList = [];

  List<SaveListModel> searchList = [];

  List<String> selectedList = [];

  List<SaveListModel> userSaveList = [];

  bool viseble = false;

  var isLoading = true;

  final _method = FirestoreMethods();

  TextEditingController controller = TextEditingController();

  onInit() {
    super.onInit();
    getSaveItems();
    getUserSaveList();
    controller.addListener(getSearchList);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getUserSaveList() async {
    userSaveList = await _method.getUserSavedItems(uid);
    update();
  }

  void getSearchList() {
    searchList = [];
    print('------------out');
    if (controller.text.isEmpty) {
      print('iiiiiiiiiiiiiiiii');

      searchList.addAll(saveItemList);
      isLoading = false;
      update();
    } else {
      print('eeeeeeeeee');
      searchList = saveItemList
          .where((element) => element.title
              .toLowerCase()
              .contains(controller.text.toLowerCase()))
          .toList();
      update();
    }
  }

  void addToSelectList(item, condition) {
    if (condition) {
      selectedList.add(item);
      if (selectedList.length > 0) {
        viseble = true;
      } else {
        viseble = false;
      }

      update();
    } else {
      selectedList.remove(item);
      if (selectedList.length > 0) {
        viseble = true;
      } else {
        viseble = false;
      }

      update();
    }
  }

  void getSaveItems() async {
    _method.getSavedItems().then((value) {
      saveItemList = value;
      searchList = value;
      update();
      getSearchList();
    });
  }
}