import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';

import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class BuyController extends GetxController {
  String uid;

  BuyController({this.uid});

  List<SaveListModel> buyItemList = [];

  List<SaveListModel> buySearchList = [];

  List<SaveListModel> buyUserList = [];

  var isLoading = true;

  final _method = FirestoreMethods();
  TextEditingController controller = TextEditingController();

  onInit() {
    controller.addListener(getSearchList);
    getBuyList();
    getUserBuyList();
    super.onInit();
  }

  void getUserBuyList() async {
    buyUserList = await _method.getUserBuyItems(uid);
    update();
  }

  void getSearchList() {
    buySearchList = [];
    print('------------out');
    if (controller.text.isEmpty) {
      print('iiiiiiiiiiiiiiiii');

      buySearchList = buyItemList;
      update();
    } else {
      print('eeeeeeeeee');
      buySearchList = buyItemList
          .where((element) =>
              element.title
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()) ||
              element.desc
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()))
          .toList();
      update();
    }
  }

  getBuyList() async {
    buyItemList = await _method.getBuyedItems();

    isLoading = false;
    getSearchList();
    update();
  }
}
