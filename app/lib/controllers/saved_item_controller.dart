import 'package:get/get.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:sales_snap/repositories/database_helper.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class SavedController extends GetxController {
  List<SavedProduct> saveItemList = [];

  List<SavedProduct> buyItemList = [];

  final _method = FireStoreMethod();

  bool isLoading = false;

  onInit() {
    getSavedList();
    getBuyList();
    super.onInit();
  }

  DatabaseHelper _helper = DatabaseHelper();
  void getSavedList() async {
    // saveItemList = await _helper.getWebDetails();
    saveItemList = await _method.getSavedItems();
    print('list item------ ${saveItemList.length}');
    update();
  }

  getBuyList() async {
    buyItemList = await _method.getbuyItems();
    isLoading = true;
    update();
  }
}
