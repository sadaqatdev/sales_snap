import 'package:get/get.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class PriceSavingController extends GetxController {
  Rx<List<BuyModel>> monthlySaveList = Rx<List<BuyModel>>();
  Rx<List<BuyModel>> weeklySaveList = Rx<List<BuyModel>>();
  Rx<List<BuyModel>> quertlySaveList = Rx<List<BuyModel>>();
  final _method = FireStoreMethod();

  List<double> weeklyList = [];
  List<double> monthlyList = [];
  List<double> quertlyList = [];

  @override
  void onInit() {
    monthlySaveList.bindStream(_method.getMonthlys());
    weeklySaveList.bindStream(_method.getWeekly());
    quertlySaveList.bindStream(_method.getQuaterly());
    Future.delayed(Duration(seconds: 3)).then((value) {
      addTo();
    });
    super.onInit();
  }

  void addTo() {
    weeklySaveList.value.forEach((element) {
      weeklyList.add(
          double.parse(element.priceNumber) - double.parse(element.newPrice));
    });
    monthlySaveList.value.forEach((element) {
      monthlyList.add(
          double.parse(element.priceNumber) - double.parse(element.newPrice));
    });
    quertlySaveList.value.forEach((element) {
      quertlyList.add(
          double.parse(element.priceNumber) - double.parse(element.newPrice));
    });

    update();
    Future.delayed(Duration(seconds: 2)).then((value) {
      update();
    });
  }

  double get weeklyTotal {
    return weeklyList.fold(0, (previousValue, element) {
      update();
      return previousValue + element;
    });
  }

  double get monthlyTotal {
    return monthlyList.fold(0, (previousValue, element) {
      update();
      return previousValue + element;
    });
  }

  double get quertlyTotal {
    return quertlyList.fold(0, (previousValue, element) {
      update();
      return previousValue + element;
    });
  }
}
