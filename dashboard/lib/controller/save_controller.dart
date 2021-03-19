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
  List<String> uidList = [];

  List<SaveListModel> userSaveList = [];

  bool viseble = false;

  String webUrl = '';

  String avataUrl = '';

  String priceHtmlTag = '';

  String price = '';

  var isLoading = true;

  final _method = FirestoreMethods();

  TextEditingController searchcontroller = TextEditingController();

  onInit() {
    super.onInit();
    getSaveItems();
    getUserSaveList();
    searchcontroller.addListener(getSearchList);
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  void getUserSaveList() async {
    userSaveList = await _method.getUserSavedItems(uid);
    update();
  }

  void getSearchList() {
    searchList = [];
    print(saveItemList.toString());
    print('------------out');
    if (searchcontroller.text.isEmpty) {
      print('iiiiiiiiiiiiiiiii');
      print(searchList.toString());
      searchList.addAll(saveItemList);
      isLoading = false;
      update();
    } else {
      print('eeeeeeeeee');
      searchList = saveItemList
          .where((element) => element.title
              .toLowerCase()
              .contains(searchcontroller.text.toLowerCase()))
          .toList();
      update();
    }
  }

  void addToSelectList(item, condition, url, uid, avata, priceHtmlTag, price) {
    webUrl = url;
    avataUrl = avata;
    this.price = price;
    this.priceHtmlTag = priceHtmlTag;
    print('--------varate--');
    print(avataUrl);
    if (condition) {
      selectedList.add(item);
      uidList.add(uid);
      if (selectedList.length > 0) {
        viseble = true;
      } else {
        viseble = false;
      }

      update();
    } else {
      selectedList.remove(item);
      uidList.remove(uid);
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
    Future.delayed(Duration(seconds: 2)).then((value) {
      update();
    });
  }
}
