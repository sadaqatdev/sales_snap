import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';

import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class SaveController extends GetxController {
  String uid;

  String productTitle;
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
    searchcontroller.addListener(getSearchList);
    getSaveItems();
    if(uid!=null)
     getUserSaveList();
    
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
      searchList.addAll(saveItemList);
      
      update();
    } else {
      searchList = saveItemList
          .where((element) => element.title
              .toLowerCase()
              .contains(searchcontroller.text.toLowerCase()))
          .toList();
      update();
    }
  }

  void addToSelectList(
      item, condition, url, uid, avata, priceHtmlTag, price, productTitle) {
    webUrl = url;
    avataUrl = avata;
    this.price = price;
    this.priceHtmlTag = priceHtmlTag;
    this.productTitle = productTitle;
    viseble = true;
    update();
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
    saveItemList   =await _method.getSavedItems();
    getSearchList();
    isLoading=false;
      update();
  }
}
