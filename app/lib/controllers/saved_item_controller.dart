import 'package:get/get.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/models/save_product_model.dart';
import 'package:sales_snap/repositories/database_helper.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class SavedController extends GetxController {
  static SavedController get to => Get.find<SavedController>();
  List<SavedProductModel> saveItemList = [];

  List<BuyModel> buyItemList = [];

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
    print('------buy list-');
    print(buyItemList.toString());
    isLoading = true;
    update();
  }
}
