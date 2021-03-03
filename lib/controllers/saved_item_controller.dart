import 'package:get/get.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:sales_snap/repositories/database_helper.dart';

class SavedController extends GetxController {
  List<WebDetails> saveItemList = [];
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
