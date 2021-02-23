import 'package:get/get.dart';
import 'package:sales_snap/repositories/database_helper.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class SavedController extends GetxController {
  List saveItemList = [];
  // FireStoreMethod _method = FireStoreMethod();
  onInit() {
    getSavedList();
    super.onInit();
  }

  DatabaseHelper _helper = DatabaseHelper();
  void getSavedList() async {
    saveItemList = await _helper.getWebDetails();
    print('list item------ ${saveItemList.length}');
    update();
  }

  // getSavedFireStoreList() async {
  //   saveItemList = await _method.getSavedItems();
  //   update();
  // }
}
