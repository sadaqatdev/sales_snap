import 'package:get/get.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class PriceSavingController extends GetxController {
  Rx<List<BuyModel>> previosMonth = Rx<List<BuyModel>>();
  Rx<List<BuyModel>> previosMonthTwo = Rx<List<BuyModel>>();
  Rx<List<BuyModel>> currentlyMonth = Rx<List<BuyModel>>();
  final _method = FireStoreMethod();

  List<double> weeklyList = [];
  List<double> monthlyList = [];
  List<double> quertlyList = [];

  @override
  void onInit() {
    previosMonth.bindStream(_method.getPreviousMonth());
    previosMonthTwo.bindStream(_method.getPreviousMonthTwo());
    currentlyMonth.bindStream(_method.getCurrentMonth());
    Future.delayed(Duration(seconds: 3)).then((value) {
      addTo();
    });
    super.onInit();
  }

  void addTo() {
    previosMonthTwo.value.forEach((element) {
      weeklyList.add(
          double.parse(element.priceNumber) - double.parse(element.newPrice));
    });
    previosMonth.value.forEach((element) {
      monthlyList.add(
          double.parse(element.priceNumber) - double.parse(element.newPrice));
    });
    currentlyMonth.value.forEach((element) {
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
