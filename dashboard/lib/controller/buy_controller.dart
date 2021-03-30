import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/buy_model.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';

import 'package:sales_snap_dashboard/servises/firestore_methods.dart';

class BuyController extends GetxController {
  String uid;

  BuyController({this.uid});

  List<BuyModel> buyItemList = [];

  List<BuyModel> buySearchList = [];

  List<BuyModel> buyUserList = [];

  var isLoading = true;

  final _method = FirestoreMethods();

  TextEditingController controller = TextEditingController();
  var startDate = DateTime(2020, 1, 1, 1, 1);

  var endDate = DateTime.now();
  onInit() {
    super.onInit();
    controller.addListener(getBuySearchList);
    getBuyList();
     if(uid!=null)
     getUserBuyList();
    
  }

  void getUserBuyList() async {
    buyUserList = await _method.getUserBuyItems(uid);
    update();
  }

  void getBuySearchList() {
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
    buyItemList = await _method.getBuyedItems(startDate, endDate);

    isLoading = false;
    getBuySearchList();
    update();
  }
}
